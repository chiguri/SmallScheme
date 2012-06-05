package smallScheme;

public enum SSSyntax {
	 // Ç†Ç≠Ç‹Ç≈ÅAêÊì™Ç™Ç±ÇÍÇ©ÅAÇµÇ©å©Ç»Ç¢  visitorÇ≈é¿ëï
	DEFINE,
	DEFINEMACRO,
	LOAD,
	LAMBDA,
	QUOTE,
	SET,
	IF,
	BEGIN,
	WHILE,
	MACRO, // may be macro, but not sure
// listed on the above are syntax, and followings are type
	PAIR,
	SYMBOL,
	INTEGER,
	BOOL,
	STRING,
	FUNCTION,
	NULL,
	VOID,
/*	template for switch statement
	case DEFINE:
	case DEFINEMACRO:
	case LOAD:
	case LAMBDA:
	case QUOTE:
	case SET:
	case IF:
	case BEGIN:
	case WHILE:
	case MACRO:
	case PAIR:
	case SYMBOL:
	case INTEGER:
	case BOOL:
	case STRING:
	case FUNCTION:
	case NULL:
	case VOID:
*/
}
