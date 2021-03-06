//@see: https://github.com/jongpie/NebulaFramework/blob/dev/src/classes/TestingUtils.cls
@isTest
public with sharing class TEST_ReadOnlyHelper {
    public static SObject setReadOnlyField(SObject sobj, Map<Schema.SObjectField, Object> changesToFields) {
        String serializedRecord = JSON.serialize(sobj);
        Map<String, Object> deserializedRecordMap = (Map<String, Object>)JSON.deserializeUntyped(serializedRecord);

        // Loop through the deserialized record map and put the field & value
        // Since it's a map, if the field already exists on the SObject, it's updated (or added if it wasn't there already)
        for(Schema.SObjectField sobjectField : changesToFields.keySet()) {
            String fieldName = sobjectField.getDescribe().getName();
            deserializedRecordMap.put(fieldName, changesToFields.get(sobjectField));
        }

        String reserializedRecord = JSON.serialize(deserializedRecordMap);
        return (SObject)JSON.deserialize(reserializedRecord, SObject.class);
    }  
}