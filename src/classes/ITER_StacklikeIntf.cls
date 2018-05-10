public interface ITER_StacklikeIntf {
    Iterator<Object> push(Object value);
    ITER_UnloadOneValueFromStackResultIntf pop();
    ITER_UnloadOneValueFromStackResultIntf shift();
    Iterator<Object> unshift(Object value);
}