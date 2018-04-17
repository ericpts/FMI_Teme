extern crate ndarray;

use std::fs::File;
use std::io::Read;
use ndarray::prelude::*;

type Terminal = u8;
type Nonterminal = u8;

#[derive(Debug)]
enum Rule {
    Nonterminal {
        src: Nonterminal,
        dst: [Nonterminal; 2],
    },
    Terminal {
        src: Nonterminal,
        dst: Terminal,
    },
}

fn char_to<T: From<u8>>(c: &char) -> T {
    let mut buf = [0; 4];
    let r = c.encode_utf8(&mut buf);
    T::from(r.bytes().next().expect("failed to parse src"))
}

impl Rule {
    fn new(line: &str) -> Result<Rule, String> {
        let tokens: Vec<&str> = line.split_whitespace().collect();

        let src = tokens[0].chars().next().ok_or("source must be a non terminal")?;

        macro_rules! err {
            ($e:expr) => {
                return Err(format!("{}!\n Rule must look like S -> AB or S -> a", $e));
            }
        }

        if tokens.len() != 3 ||
            tokens[0].len() != 1 ||
            tokens[1] != "->" ||
            !src.is_uppercase() {
            err!("invalid format");
        }

        let dst_vec: Vec<char> = tokens[2].chars().collect();

        if dst_vec.len() == 1 {
            let dst = dst_vec[0];
            if !dst.is_lowercase() {
                err!("dest is terminal but not lowercase");
            }
            return Ok(Rule::Terminal {
                src: char_to::<Nonterminal>(&src),
                dst: char_to::<Terminal>(&dst),
            });
        }

        if dst_vec.len() == 2 {
            for d in &dst_vec {
                if !d.is_uppercase() {
                    err!("dest is nonterminal but not uppercase");
                }
            }

            let dst: [Nonterminal; 2] = [
                char_to::<Nonterminal>(&dst_vec[0]),
                char_to::<Nonterminal>(&dst_vec[1]),
            ];

            return Ok(Rule::Nonterminal {
                src: char_to::<Nonterminal>(&src),
                dst: dst,
            });
        }

        err!("dest has invalid length (not 1 nor 2)");
    }

    fn src(&self) -> u8 {
        let src = match self {
            &Rule::Nonterminal{src, ..} => src,
            &Rule::Terminal{src, ..} => src,
        };
        src
    }

    fn is_terminal(&self) -> bool {
        match self {
            &Rule::Nonterminal{src, ..} => false,
            &Rule::Terminal{src, ..} => true,
        }
    }

    fn is_nonterminal(&self) -> bool {
        return !self.is_terminal();
    }

    fn terminal(&self) -> Result<u8, String> {
        match self {
            &Rule::Nonterminal{..} => Err(String::from("rule is nonterminal")),
            &Rule::Terminal{dst, ..} => Ok(dst),
        }
    }
}

fn build_matrix(rules: &Vec<Rule>, target: &Vec<Terminal>) {
    /// Tries to generate string target from the given rules.
    ///
    /// Returns the Nonterminals that you can start with and reach the target,
    /// together with the matrix itself.

    // dp[i][j][k] = is it possible to generate the substring [i..j] of `target`, starting from
    // nonterminal `k?`
    let n = target.len();
    let s = 255;

    let terminals: Vec<u8> = rules.iter().map(|rule| rule.src()).collect();

    let mut dp = Array3::<bool>::default((n, n, s));

    for r in rules.iter().filter(|rule| rule.is_terminal()) {
        for i in 0..n {
            if target[i] != r.terminal().unwrap() {
                continue;
            }
            dp[[i, i, r.src() as usize]] = true;
        }
    }

    for len in 0..n {
        for i in 0..n {
            let j = i + len - 1;
        }
    }
}

fn main() {
    let fname = "gramatica.txt";

    let mut f = File::open(fname).expect(&format!("could not open {}", fname));

    let mut s = String::new();
    f.read_to_string(&mut s).expect(&format!("failed to read file {}", fname));

    let rules: Vec<Rule> = s.lines().map(|line| {
        Rule::new(line).expect(&format!("could not parse rule {}", line))
    }).collect();
}
