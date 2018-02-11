public class Env {
    // You have to re-implement this to make your SemanticChecker works correct
    public java.util.HashMap<String, Object> table = new java.util.HashMap<String, Object>();
    public Env prev;
    public Env(Env p)
    {
        // You have to re-implement this to make your SemanticChecker works correct
        prev = p;
    }
    public void Put(String name, Object value)
    {
        // You have to re-implement this to make your SemanticChecker works correct
        assert name != null;
        assert value != null;
        table.put(name, value);
    }
    public Object Get(String name)
    {
        // You have to re-implement this to make your SemanticChecker works correct
        if(table.containsKey(name))
            return table.get(name);
        else if(prev != null)
            return prev.Get(name);

        return null;
    }
}
