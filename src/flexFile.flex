import java.util.*;
%%
%class JflexScanner
%standalone
%line
%column

Float = \d+\.?\d*
Integer = \d+
L_PAREN = \(
R_PAREN = \)
Semicolon = ;
If = if
Not= \!
Less = \<
NotEqual = \!\=
LessThanEqual = \<\=
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = {LineTerminator} | [ \t\f]
Identifier = [:jletter:] [:jletterdigit:]*

 /* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment}

TraditionalComment   = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
EndOfLineComment     = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent       = ( [^*] | \*+ [^/*] )*


%{
    enum tokenType {
    R_PAREN,
    L_PAREN,
    SCOLON,
    NEQ,
    NOT,
    LESS,
    LEQ,
    INT,
    FLOAT,
    ID,
    INVALID,
    IF,
    EOF
}
    class token{
    tokenType tokenType;
    String identifierName;
    int intValue;
    float floatValue;
    public token(tokenType tokenType,String identifierName){
        this.tokenType=tokenType;
        this.identifierName=identifierName;
    }
    public token(tokenType tokenType,int integerValue){
        this.tokenType=tokenType;
        this.intValue=integerValue;
    }
    public token(tokenType tokenType,float floatValue){
        this.tokenType=tokenType;
        this.floatValue=floatValue;
    }
    public token(tokenType tokenType){
        this.tokenType=tokenType;
    }
}
%}

%eof{
     token newToken = new token(tokenType.EOF);
    System.out.println(newToken.tokenType);
    
%eof}

%%

{L_PAREN} {
    token newToken = new token(tokenType.L_PAREN);
    System.out.println(newToken.tokenType);
}

{R_PAREN} {
    token newToken = new token(tokenType.R_PAREN);
    System.out.println(newToken.tokenType);
}

{Integer} {
    token newToken = new token(tokenType.INT,yytext());
    System.out.println(newToken.tokenType+" VALUE : "+ newToken.identifierName);
    }

{Float} {
    token newToken = new token(tokenType.FLOAT,yytext());
    System.out.println(newToken.tokenType+" VALUE : "+ newToken.identifierName);
    }

{Semicolon} {
    token newToken = new token(tokenType.SCOLON);
    System.out.println(newToken.tokenType);
}

{NotEqual} {
    token newToken = new token(tokenType.NEQ);
    System.out.println(newToken.tokenType);
}

{Not} {
    token newToken = new token(tokenType.NOT);
    System.out.println(newToken.tokenType);
}

{LessThanEqual} {
    token newToken = new token(tokenType.LEQ);
    System.out.println(newToken.tokenType);
}

{Less} {
    token newToken = new token(tokenType.LESS);
    System.out.println(newToken.tokenType);
}

{If} {
    token newToken = new token(tokenType.IF);
    System.out.println(newToken.tokenType);
}
{Identifier} {
    token newToken = new token(tokenType.ID,yytext());
    System.out.println(newToken.tokenType+" VALUE : "+ newToken.identifierName);
}

\n          {/*Do nothing*/}
{WhiteSpace} {/*Do nothing*/}
{Comment}   {/*Do nothing*/}
.  {
     token newToken = new token(tokenType.INVALID,yytext());
    System.out.println(newToken.tokenType+" VALUE : "+ newToken.identifierName);
}