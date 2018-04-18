#!/usr/bin/env python3
import sys
import string
from pathlib import Path
import pdb
from typing import List, Tuple, Dict


class Rule(object):
    def __init__(self, src: str, dst: str) -> None:
        assert src in string.ascii_uppercase

        self.src = src
        self.dst = dst

        if len(dst) == 2:
            for d in dst:
                assert d in string.ascii_uppercase
        else:
            assert dst in string.ascii_lowercase

    def __repr__(self) -> str:
        return '{} -> {}'.format(self.src, self.dst)

    def is_terminal(self) -> bool:
        return len(self.dst) == 1

    def is_nonterminal(self) -> bool:
        return not self.is_terminal()



def parse_file(f: Path) -> List[Rule]:
    with open('gramatica.txt', 'rt') as f:
        data = f.read()

    ret = []  # type: List[Rule]
    for l in [s.strip() for s in data.splitlines()]:
        r = l.split()

        assert len(r) == 3
        assert r[1] == '->'

        src = r[0]
        dst = r[2]

        assert len(src) == 1
        assert len(dst) in [1, 2]
        ret.append(Rule(src, dst))

    return ret


def build_matrix(rules: List[Rule], target: str) -> Tuple[
        List[List[List[bool]]],
        List[List[List[Tuple]]],
        Dict[str, int]]:
    nt_v = [r.src for r in rules]
    nt = {x: i for (i, x) in enumerate(nt_v)}

    n = len(target)
    p = len(nt_v)

    # dp[i][j][k] = can we obtain the subsequence [i..j] of @target starting
    # from the @k nonterminal?
    # If no, then it is Non. Otherwise, it is a positive integer - the number
    # of rules to apply.
    dp = [[[None for _ in range(p)]
           for _ in range(n)]
          for _ in range(n)]

    # prev[i][j][k] = pair (l, rule):
    # for generating the subsequence i..j, which rule was used
    # and where was the split?
    prev = [[[() for _ in range(p)]
             for _ in range(n)]
            for _ in range(n)]

    # Base case, when i == j.
    # Those surely come from a single terminal rule.
    for r in rules:
        if not r.is_terminal():
            continue
        src = nt[r.src]

        c = r.dst[0]
        for i in range(n):
            if target[i] != c:
                continue
            dp[i][i][src] = 1

            prev[i][i][src] = (None, r)

    for l in range(1, n):
        for i in range(n - l):
            j = i + l
            for r in rules:
                if not r.is_nonterminal():
                    continue
                assert r.is_nonterminal()

                s = nt[r.src]

                d0 = nt[r.dst[0]]
                d1 = nt[r.dst[1]]

                # dp[i][j][s] == min over (dp[i][k][d0] AND dp[k + 1][j][d1])
                sol = None
                sol_k = None
                for k in range(i, j):
                    if dp[i][k][d0] is None or dp[k + 1][j][d1] is None:
                        continue
                    now = dp[i][k][d0] + dp[k + 1][j][d1]
                    if sol is None or now < sol:
                        sol = now
                        sol_k = k

                if sol is None:
                    continue

                sol += 1
                if dp[i][j][s] is None or sol < dp[i][j][s]:
                    prev[i][j][s] = (sol_k, r)
                    dp[i][j][s] = sol


    return (dp, prev, nt)

def main():
    rules = parse_file(Path('gramatica.txt'))
    for t in sys.stdin:
        t = t.strip()
        (dp, prev, nt) = build_matrix(rules, t)
        assert 'S' in nt

        n = len(t)

        ans = dp[0][n - 1][nt['S']]

        if ans is None:
            print('{} cannot be obtained starting from S'.format(t))
            continue

        print('minimum number of productions is {}'.format(ans))

        def show(i: int, j: int, s: str) -> List[str]:
            (l, rule) = prev[i][j][nt[s]]

            if l is None:
                assert rule.is_terminal()
                return [s, rule.dst]

            assert rule.is_nonterminal()

            p1 = show(i, l, rule.dst[0])
            p2 = show(l + 1, j, rule.dst[1])

            pf1 = [p + rule.dst[1] for p in p1]
            endf1 = p1[-1]

            pf2 = [endf1 + p for p in p2[1:]]

            return [s] + pf1 + pf2

        path = show(0, n - 1, 'S')
        assert path[-1] == t
        print(' -> '.join(path))


if __name__ == '__main__':
    main()
