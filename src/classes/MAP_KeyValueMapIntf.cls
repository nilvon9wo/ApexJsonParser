public interface MAP_KeyValueMapIntf {
    Set<Object> getKeys();
    List<Object> getValues();
    Object getKey(Object value);
    Object setKey(Object key, Object value);
}