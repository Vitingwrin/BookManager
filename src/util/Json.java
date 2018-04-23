package util;

public class Json {
    private StringBuilder json;
    public Json(){
        json = new StringBuilder("{");
    }
    public void putName(String name){
        json.append("\"").append(name).append("\":");
    }
    public void putVaule(String value){
        json.append("\"").append(value).append("\",");
    }
    public String toString(){
        json.deleteCharAt(json.length() - 1);
        json.append("}");
        return json.toString();
    }
    public void clear(){
        json.delete(0, json.length());
        json.append("{");
    }
}
