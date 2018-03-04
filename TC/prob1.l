%option c++
%option noyywrap
%option yylineno

ws [ \t\n]+
alpha [A-Za-z]
digit [0-9]
name ({alpha}|[_])({alpha}|{digit}|[_])*
string \"[^\n"]+\"

number_int [-+]?{digit}+
number_float {number_int}\.{digit}+

comment \/\/.*$

%{
#include <vector>
#include <memory>
#include <iostream>
#include <sstream>
#include <cassert>

#include "token.h"

std::vector<std::unique_ptr<Token>> _tokens;

void add_token(std::unique_ptr<Token> token)
{
    _tokens.push_back(std::move(token));
}

%}

%%
{ws}

"int" {
    g_lineno = yylineno;
    add_token(Token_Int::make());
}

"float" {
    g_lineno = yylineno;
    add_token(Token_Float::make());
}

"return" {
    g_lineno = yylineno;
    add_token(Token_Return::make());
}

"if" {
    g_lineno = yylineno;
    add_token(Token_If::make());
}

"for" {
    g_lineno = yylineno;
    add_token(Token_For::make());
}

"(" {
    g_lineno = yylineno;
    add_token(Token_OpenParen::make());
}

")" {
    g_lineno = yylineno;
    add_token(Token_ClosedParen::make());
}

"{" {
    g_lineno = yylineno;
    add_token(Token_OpenBracket::make());
}

"}" {
    g_lineno = yylineno;
    add_token(Token_ClosedBracket::make());
}

";" {
    g_lineno = yylineno;
    add_token(Token_Semicolon::make());
}

":" {
    g_lineno = yylineno;
    add_token(Token_Colon::make());
}

"=" {
    g_lineno = yylineno;
    add_token(Token_Equal::make());
}

"+" {
    g_lineno = yylineno;
    add_token(Token_Plus::make());
}

"-" {
    g_lineno = yylineno;
    add_token(Token_Minus::make());
}

"*" {
    g_lineno = yylineno;
    add_token(Token_Asterisk::make());
}

"/" {
    g_lineno = yylineno;
    add_token(Token_Slash::make());
}

"!" {
    g_lineno = yylineno;
    add_token(Token_Exclamation::make());
}

"?" {
    g_lineno = yylineno;
    add_token(Token_QuestionMark::make());
}

"&" {
    g_lineno = yylineno;
    add_token(Token_Ampersand::make());
}

"|" {
    g_lineno = yylineno;
    add_token(Token_VerticalBar::make());
}

{string} {
    g_lineno = yylineno;
    add_token(Token_String::make(yytext));
}

{number_int} {
    g_lineno = yylineno;
    std::stringstream ss(yytext);
    int x;
    ss >> x;
    add_token(Token_Number_Int::make(x));
}

{number_float} {
    g_lineno = yylineno;
    std::stringstream ss(yytext);
    float x;
    ss >> x;
    add_token(Token_Number_Float::make(x));
}

{name} {
    g_lineno = yylineno;
    add_token(Token_Name::make(yytext));
}

{comment} {
    g_lineno = yylineno;
    std::cerr << yytext;
}

%%



int main( int /* argc */, char** /* argv */ )
{
    FlexLexer* lexer = new yyFlexLexer;
    while(lexer->yylex() != 0)
        ;

    for (const auto & t : _tokens) {
        std::cout << t->to_string() << "\n";
    }
    return 0;
}
