extern crate ndarray;

use std::fs::File;
use std::io::Read;
use ndarray::prelude::*;


type Terminal = char;
type Nonterminal = char;

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

fn char_to_i32(c: char) -> i32 {
    let mut buf = [0; 4];
    let r = c.encode_utf8(&mut buf);
    r.bytes().next().expect("failed to parse src") as i32
}

impl Rule {
    fn new(line: &str) -> Result<Rule, String> {
        let tokens: Vec<&str> = line.split_whitespace().collect();

        let src = tokens[0].chars().next().ok_or("source must be a non terminal")?;

        macro_rules! err {
            ($e:expr) => {
                return Err(format!("rule must look like S -> AB or S -> a: {}", $e));
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
                src: src,
                dst: dst,
            });
        }

        if dst_vec.len() == 2 {
            for d in &dst_vec {
                if !d.is_uppercase() {
                    err!("dest is nontermianl but not uppercase");
                }
            }

            let dst = [dst_vec[0], dst_vec[1]];
            return Ok(Rule::Nonterminal {
                src: src,
                dst: dst,
            });
        }

        err!("dest has invalid length (not 1 nor 2)");
    }

    fn src(&self) -> i32 {
        let src = match self {
            &Rule::Nonterminal{src, ..} => src,
            &Rule::Terminal{src, ..} => src,
        };
        char_to_i32(src)
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
}

fn build_matrix(rules: &Vec<Rule>, target: &str) {
    /// Tries to generate string target from the given rules.
    ///
    /// Returns the Nonterminals that you can start with and reach the target,
    /// together with the matrix itself.

    // DP[i][j][k] = is it possible to generate the substring [i..j] of `target`, starting from
    // nonterminal `k?`
    let n = target.len();
    let s = 255;

    let terminals: Vec<i32> = rules.iter().map(|rule| rule.src()).collect();

    let mut DP = Array3::<bool>::default((n, n, s));

    for r in rules.iter().filter(|rule| rule.is_terminal()) {
        for i in 0..n {
            if target[i] == r.
            DP[i][i][r.src()]
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
