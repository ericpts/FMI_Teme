#include <string>
#include <memory>

#include "util.h"

enum class TokenType
{
    // Actual data.
    Number_Int,
    Number_Float,
    String,
    Name,
    SpecialName,


    // Data types.
    Int,
    Float,

    // Keywords.
    Return,
    If,
    For,

    // Parantheses.
    OpenParen,
    ClosedParen,

    // Brackets.
    OpenBracket,
    ClosedBracket,


    // Punctuation.
    Quotation,
    Semicolon,
    Colon,
    Equal,
    Plus,
    Minus,
    Asterisk,
    Slash,
    Exclamation,
    QuestionMark,
    Ampersand,
    VerticalBar,


    // Comments.
    Comment,
};

int g_lineno = 0;

struct Token
{
    // The type of the token.
    TokenType m_type;

    // Line where this token was scanned.
    int m_line;

    Token(TokenType type, int line = g_lineno):
        m_type(type),
        m_line(line)
    { }

    virtual std::string to_string() const = 0;

    virtual ~Token() = default;
};

#define define_simple_token(name) \
struct Token_##name : public Token \
{\
    Token_##name(): Token(TokenType::name) { }\
\
    template<typename... Args>\
    static std::unique_ptr<Token> make()\
    {\
        return std::make_unique<Token_##name>();\
    }\
\
    std::string to_string() const\
    {\
        return "Token(" #name ") @ " + std::to_string(m_line);\
    }\
};

define_simple_token(Int);
define_simple_token(Float);

define_simple_token(Return);
define_simple_token(If);
define_simple_token(For);

define_simple_token(OpenParen);
define_simple_token(ClosedParen);

define_simple_token(OpenBracket);
define_simple_token(ClosedBracket);

define_simple_token(Semicolon);
define_simple_token(Colon);
define_simple_token(Equal);
define_simple_token(Plus);
define_simple_token(Minus);
define_simple_token(Asterisk);
define_simple_token(Slash);
define_simple_token(Exclamation);
define_simple_token(QuestionMark);
define_simple_token(Ampersand);
define_simple_token(VerticalBar);


#undef define_simple_token

struct Token_String : public Token
{
    std::string m_data;

    Token_String(std::string data):
        Token(TokenType::String),
        m_data(data)
    { }

    static std::unique_ptr<Token> make(std::string data)
    {
        return std::make_unique<Token_String>(data);
    }

    std::string to_string() const
    {
        return sformatf("Token_String(%s) @ %d", m_data.c_str(), m_line);
    }
};

struct Token_SpecialName : public Token
{
    std::string m_data;

    Token_SpecialName(std::string data):
        Token(TokenType::SpecialName),
        m_data(data)
    { }

    static std::unique_ptr<Token> make(std::string data)
    {
        return std::make_unique<Token_SpecialName>(data);
    }

    std::string to_string() const
    {
        return sformatf("Token_SpecialName(%s) @ %d", m_data.c_str(), m_line);
    }
};

struct Token_Name : public Token
{
    std::string m_data;

    Token_Name(std::string data):
        Token(TokenType::Name),
        m_data(data)
    { }

    static std::unique_ptr<Token> make(std::string data)
    {
        return std::make_unique<Token_Name>(data);
    }

    std::string to_string() const
    {
        return sformatf("Token_Name(%s) @ %d", m_data.c_str(), m_line);
    }
};

struct Token_Number_Int : public Token
{
    int m_data;

    Token_Number_Int(int data):
        Token(TokenType::Number_Int),
        m_data(data)
    { }

    static std::unique_ptr<Token> make(int data)
    {
        return std::make_unique<Token_Number_Int>(data);
    }

    std::string to_string() const
    {
        return sformatf("Token_Number_Int(%s) @ %d", std::to_string(m_data).c_str(), m_line);
    }
};

struct Token_Number_Float : public Token
{
    float m_data;

    Token_Number_Float(float data):
        Token(TokenType::Number_Float),
        m_data(data)
    { }

    static std::unique_ptr<Token> make(float data)
    {
        return std::make_unique<Token_Number_Float>(data);
    }

    std::string to_string() const
    {
        return sformatf("Token_Number_Float(%s) @ %d", std::to_string(m_data).c_str(), m_line);
    }
};

struct Token_Comment : public Token
{
    std::string m_data;

    Token_Comment(std::string data):
        Token(TokenType::Comment),
        m_data(data)
    { }

    static std::unique_ptr<Token> make(std::string data)
    {
        return std::make_unique<Token_Comment>(data);
    }

    std::string to_string() const
    {
        return sformatf("Token_Comment(%s) @ %d", m_data.c_str(), m_line);
    }
};

