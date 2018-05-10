public class UTIL_MapBuilder {
    public static Map<Id, List<SObject>> mapBySpecifiedIdField (List<SObject> homogeneousSObjectList, SObjectField idField) {
	    if (homogeneousSObjectList == null || homogeneousSObjectList.isEmpty()) {
	        return null;
	    }
	
	    Map<Id, List<SObject>> sObjectSetBySpecifiedIdMap = new Map<Id, List<SObject>>();
	    for (SObject sObj : homogeneousSObjectList) {
	        Id specifiedId = (Id) sObj.get(idField);
	        if (!String.isBlank(specifiedId)) {
	            if (!sObjectSetBySpecifiedIdMap.containsKey(sObj.Id)) {
	                sObjectSetBySpecifiedIdMap.put(sObj.Id, new List<SObject>());
	            }
	            sObjectSetBySpecifiedIdMap.get(sObj.id).add(sObj); 
	        }
	    }
	
	    String mapType = 'Map<Id, List<' + homogeneousSObjectList[0].getSObjectType() + '>>';
	    Map<Id, List<SObject>> concreteSObjectSetByIdMap = (Map<Id, List<SObject>>)Type.forName(mapType).newInstance();
	    concreteSObjectSetByIdMap.putAll(sObjectSetBySpecifiedIdMap);

	    return concreteSObjectSetByIdMap;
	}
	
    public static Map<Id, SObject> mapBySpecifiedUniqueIdField (List<SObject> homogeneousSObjectList, SObjectField idField) {
	    if (homogeneousSObjectList == null || homogeneousSObjectList.isEmpty()) {
	        return null;
	    }
	
	    Map<Id, SObject> sObjectSetBySpecifiedIdMap = new Map<Id, SObject>();
	    for (SObject sObj : homogeneousSObjectList) {
	        Id specifiedId = (Id) sObj.get(idField);
	        if (!String.isBlank(specifiedId)) {
	            if (sObjectSetBySpecifiedIdMap.containsKey(sObj.Id)) {
	            	throw new UTIL_MapBuilderException(
	            	    'Id ' + sObj.Id + ' is not unique;'
	            	    + ' shared by ' + sObjectSetBySpecifiedIdMap.get(sObj.Id)
	            	    + ' and ' + sObj
	            	);
	            }
	            sObjectSetBySpecifiedIdMap.put(sObj.id, sObj); 
	        }
	    }
	
	    String mapType = 'Map<Id, ' + homogeneousSObjectList[0].getSObjectType() + '>';
	    Map<Id, SObject> concreteSObjectSetByIdMap = (Map<Id, SObject>)Type.forName(mapType).newInstance();
	    concreteSObjectSetByIdMap.putAll(sObjectSetBySpecifiedIdMap);

	    return concreteSObjectSetByIdMap;
	}    
}