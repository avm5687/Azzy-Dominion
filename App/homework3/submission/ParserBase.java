import java.util.ArrayList;
import java.util.*;

@SuppressWarnings("unchecked")
public class ParserBase
{
    public  int   linenum;
    Env env = new Env(null);
    HashMap<String, Object> table = new HashMap<String, Object>();
    HashMap<String, Object> table2 = new HashMap<String, Object>();

	Object CallProgram(Object decl_list, Object main_decl)
	{
		((ArrayList<Object>)decl_list).add(main_decl);
        return decl_list;
	}
	Object calldecllisteps()
	{	
		return new ArrayList<Object>();
	}
	Object calldec(Object fun_decl)
	{
		return "calldec";
	}
	Object calldecllist(Object decl_list, Object decl)
	{
		((ArrayList<Object>)decl_list).add(decl);
		return decl_list;
	}
	Object CallIfStmt(Object if_stmt)
	{
		return if_stmt;
	}
	String CallIfEstmt(String expr, Object stmt, Object stmt2) throws Exception
	{
		if(expr == "bool")
			return "bool";

		else
		{
			System.out.println("Error at line "+linenum+": if statement accepts only boolean variables for condition.");
			throw new Exception();
		}
	}
	Object CallMain(Object compound_stmt)
	{
		return compound_stmt;
	}
	Object CallExprStmt(Object expr_stmt)
	{
		return expr_stmt;
	}
	Object CallFun(Object type_spec, String ID, Object params)
	{
		// You should re-write this function since this is a simplified version
        String ID_type = (String)(env.Get(ID));
        switch((String)type_spec)
        {
            case "CallTypeInt":
            env.Put(ID, "int" );
            table.put(ID, "int");
            break;
            case "CallTypeBool": 
            env.Put(ID, "bool");
            table.put(ID, "bool");
            break;
            case "CallTypeFloat": 
            env.Put(ID, "float");
            table.put(ID, "float");
            break;
        }
        return "CallLocalDecl "+type_spec+" "+ID;
	}
	Object CallArgList(Object arg_list, String expr)
	{
		((ArrayList<Object>)arg_list).add(expr);
		return arg_list;
	}
	Object CallArgList2(String expr)
	{
		ArrayList<String> AzzyList = new ArrayList<String>();
		AzzyList.add(expr);
		return AzzyList;
	}
	Object CallArgs(Object arg_list)
	{
		return arg_list;
	}
	Object CallArgsEps()
	{
		 return new ArrayList<Object>();
	}
	Object CallTypeFloat()
	{
		return "CallTypeFloat";
	}
	Object CallTypeBool()
	{
		return "CallTypeBool";
	}
	Object CallStmtListRec(Object stmt_list, Object stmt)
	{
		((ArrayList<Object>)stmt_list).add(stmt);
		return stmt_list;
	}
	String CallORExpr(String expr, String expr2) throws Exception
	{
		if(expr == "bool" && expr2 == "bool")
			return "bool";
		else
		{
			System.out.println("Error at line "+linenum+": ("+expr+" or "+expr2+") is not allowed.");
            throw new Exception();
		}
	}
	String CallANDExpr(String expr, String expr2) throws Exception
	{
		if(expr == "bool" && expr2 == "bool")
			return "bool";
		else
		{
			System.out.println("Error at line "+linenum+": ("+expr+" and "+expr2+") is not allowed.");
            throw new Exception();
		}
	}
	String CallNOTEx(String expr) throws Exception
	{
		if(expr == "bool")
            return "bool";
        else
        {
            System.out.println("Error at line "+linenum+": (not "+expr+") is not allowed.");
            throw new Exception();
        }
	}
	String CallGreat(String expr, String expr2) throws Exception
	{
		if((expr == "int" && expr2 == "int") || (expr == "float" && expr2 == "float"))
		return "bool";

		else
		{
			System.out.println("Error at line "+linenum+": ("+expr+" > "+expr2+") is not allowed.");
            throw new Exception();
		}
	}
	String CallEqual(String expr, String expr2) throws Exception
	{
		if((expr == "int" && expr2 == "int") || (expr == "float" && expr2 == "float") || (expr == "bool" && expr2 == "bool"))
		return "bool";

		else
		{
			System.out.println("Error at line "+linenum+": ("+expr+" == "+expr2+") is not allowed.");
            throw new Exception();
		}
	}
	String CallNotEqual(String expr, String expr2) throws Exception
	{
		if((expr == "int" && expr2 == "int") || (expr == "float" && expr2 == "float") || (expr == "bool" && expr2 == "bool"))
		return "bool";

		else
		{
			System.out.println("Error at line "+linenum+": ("+expr+" != "+expr2+") is not allowed.");
            throw new Exception();
		}
	}
	String CallGreatEqual(String expr, String expr2) throws Exception
	{
		if((expr == "int" && expr2 == "int") || (expr == "float" && expr2 == "float"))
		return "bool";

		else
		{
			System.out.println("Error at line "+linenum+": ("+expr+" >= "+expr2+") is not allowed.");
            throw new Exception();
		}
	}
	String CallLess(String expr, String expr2) throws Exception
	{
		if((expr == "int" && expr2 == "int") || (expr == "float" && expr2 == "float"))
		return "bool";

		else
		{
			System.out.println("Error at line "+linenum+": ("+expr+" < "+expr2+") is not allowed.");
            throw new Exception();
		}
	}
	String CallLessEqual(String expr, String expr2) throws Exception
	{
		if((expr == "int" && expr2 == "int") || (expr == "float" && expr2 == "float"))
		return "bool";

		else
		{
			System.out.println("Error at line "+linenum+": ("+expr+" <= "+expr2+") is not allowed.");
            throw new Exception();
		}
	}
	String CallMinus(String expr, String expr2) throws Exception
	{
		if(expr == "int" && expr2 == "int")
    		return "int";
    	if((expr == "float" && expr2 == "float") || (expr == "int" && expr2 == "float") || (expr == "float" && expr2 == "int"))
    		return "float";
        else
        {
        	System.out.println("Error at line "+linenum+": ("+expr+" - "+expr2+") is not allowed.");
            throw new Exception();
        }
	}
	String CallPercent(String expr, String expr2) throws Exception
	{
		if(expr == "int" && expr2 == "int")
    		return "int";
    	if((expr == "float" && expr2 == "float") || (expr == "int" && expr2 == "float") || (expr == "float" && expr2 == "int"))
    		return "float";
        else
        {
        	System.out.println("Error at line "+linenum+": ("+expr+" % "+expr2+") is not allowed.");
            throw new Exception();
        }
	}
	String CallDivide(String expr, String expr2) throws Exception
	{
		if(expr == "int" && expr2 == "int")
    		return "int";
    	if((expr == "float" && expr2 == "float") || (expr == "int" && expr2 == "float") || (expr == "float" && expr2 == "int"))
    		return "float";
        else
        {
        	System.out.println("Error at line "+linenum+": ("+expr+" / "+expr2+") is not allowed.");
            throw new Exception();
        }
	}
	Object CallStmtListEps()
	{
       		 return new ArrayList<Object>();
	}
	Object CallWhileSt(Object while_stmt)
	{
		return while_stmt;
	}
	Object CallWhileStmt(String expr, Object stmt) throws Exception
	{
		if(expr == "bool")
			return "bool";
		else
		{
			System.out.println("Error at line "+linenum+": while statement accepts only boolean variables for condition.");
			throw new Exception();
		}
	}
	Object CallReturnStmt(Object return_stmt)
	{
		return "CallReturnStmt";
	}
	Object CallParam(Object type_spec)
	{
		return type_spec;
	}
	Object CallParam1(Object param)
	{
		ArrayList<String> Azzylist = new ArrayList<String>();
		Azzylist.add((String)param);
		return Azzylist;
	}
	Object CallParamList(Object paramList, Object param)
	{
		((ArrayList<String>)paramList).add((String)param);
		return paramList;
	}
	Object CallParamsEps()
    {
		return new ArrayList<String>();
    }
    Object CallStmtCompound(Object compound_stmt)
    {
        return "CallStmtCompound";
    }
    Object CallStmtPrint(Object print_stmt)
    {
        return "CallStmtPrint";
    }
    Object CallCompoundStmtBegin()
    {
    	env = new Env(env);
        return "CallCompoundStmtBegin";
    }
    Object CallCompoundStmtRest(Object begin, Object local_decls, Object stmt_list)
    {
    	env = env.prev;
        return "CallCompoundStmtRest";
    }
    Object CallLocalDeclsRec(Object local_decls, Object local_decl)
    {
        ((ArrayList<String>)local_decls).add((String)local_decl);
        return local_decls;
    }
    Object CallLocalDeclsEps()
    {
        return new ArrayList<String>();
    }
    Object CallLocalDecl(Object type_spec, String ID) throws Exception
    {
        // You should re-write this function since this is a simplified version
        String ID_type = (String)(env.Get(ID));
        switch((String)type_spec)
        {
            case "CallTypeInt":
            env.Put(ID, "int" );
            table2.put(ID, "int");
            break;
            case "CallTypeBool": 
            env.Put(ID, "bool");
            table2.put(ID, "bool");
            break;
            case "CallTypeFloat": 
            env.Put(ID, "float");
            table2.put(ID, "float");
            break;
        }
        return "CallLocalDecl "+type_spec+" "+ID;
    }
    Object CallTypeInt()
    {
        return "CallTypeInt";
    }
    Object CallPrintExpr(String expr)
    {
        return "print "+expr;
    }
    String CallExprAdd(String expr1, String expr2) throws Exception
    {
    	if(expr1 == "int" && expr2 == "int")
    		return "int";
    	if((expr1 == "float" && expr2 == "float") || (expr1 == "int" && expr2 == "float") || (expr1 == "float" && expr2 == "int"))
    		return "float";
        else
        {
        	System.out.println("Error at line "+linenum+": ("+expr1+" + "+expr2+") is not allowed.");
            throw new Exception();
        }
    }
    String CallExprMul(String expr1, String expr2) throws Exception
    {
        if(expr1 == "int" && expr2 == "int")
    		return "int";
    	if((expr1 == "float" && expr2 == "float") || (expr1 == "int" && expr2 == "float") || (expr1 == "float" && expr2 == "int"))
    		return "float";
        else
        {
        	System.out.println("Error at line "+linenum+": ("+expr1+" - "+expr2+") is not allowed.");
            throw new Exception();
        }
    }
    String CallExprParen(String expr)
    {
        return expr;
    }
    String CallFactorNum()
    {
        return "int";
    }
    String Callexprargs(String ID, Object args) throws Exception
    {
    	String ID_type = (String)(env.Get(ID));

    	if(table2.containsKey(ID) && table.get(ID) == null)
        {
            System.out.println("Error at line "+linenum+": "+ID_type+" variable "+ID+" cannot be used as a function");
            throw new Exception();
        }
    	if(table.get(ID) == null)
        {
            System.out.println("Error at line "+linenum+": undefined "+ID+" is used.");
            throw new Exception();
        }
        if(ID_type == "int")
            return ID_type;

        if(ID_type == "bool")
            return ID_type;
        if(ID_type == "float")
            return ID_type;

        else
        {
            System.out.println("Error at line "+linenum+": undefined "+ID+" is used.");
            throw new Exception();
        }
    }
    String CallExprId(String ID) throws Exception
    {
        // 1. in symbol table, env[ID] has its type in string, such as "int" or "bool"
        // 2. so return env[ID]
        // You should re-write this function since this is a simplified version
        // For example, if ID is function name, you should show error message.
        String ID_type = (String)(env.Get(ID));

        if(ID_type == "int")
            return ID_type;

        if(ID_type == "bool")
            return ID_type;
        if(ID_type == "float")
            return ID_type;
        else
        {
            System.out.println("Error at line "+linenum+": undefined "+ID+" is used.");
            throw new Exception();
        }
    }
    Object CallExprStmtIdAssignExpr(String ID, String expr) throws Exception
    {
        // 1. expr will have expr type
        // 2. get type of ID
        // 3. compare the ID_type and expr_type
        // 4. if their types are same, then OK
        // 5. if different, then print error message, and throw exception to stop parsing
        // You should re-write this function since this is a simplified version
        String ID_type = (String)(env.Get(ID));
        if(ID_type == expr)
            return "CallExprStmtIdAssignExpr "+ID+" "+expr;
        
        else if((ID_type == "int" && expr == "bool") || (ID_type == "int" && expr == "float") || (ID_type == "bool" && expr == "int") 
            || (ID_type == "bool" && expr == "float") || (ID_type == "float" && expr == "bool"))
        {
            System.out.println("Error at line "+linenum+": try to assign "+expr+" value to "+ID_type+" variable "+ID+".");
            throw new Exception();
        }
        else if(ID_type == null)
        {
            System.out.println("Error at line "+linenum+": undefined "+ID+" is used.");
            throw new Exception();
        }

        if(ID_type == "float" && expr == "int")
        	return "Success";
        else
        {
            System.out.println("Error at line "+linenum+": undefined "+ID+" is used.");
            throw new Exception();
        }
    }

    String CallExprTrue()
    {
        // in this semantic checker, you can return type of value
        return "bool";
    }
    String CallExprFalse()
    {
        // in this semantic checker, you can return type of value
        return "bool";
    }
}
