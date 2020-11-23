public with sharing class SchemaVisualizationData {
    public class ComboboxOption {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;

        public ComboboxOption(String label, String value) {
            this.label = label;
            this.value = value;
        }
    }

    public class SObjectData {
        @AuraEnabled
        public String iconName;
        @AuraEnabled
        public SObjectDescription description;
        @AuraEnabled
        public List<FieldDescription> fields;

        public SObjectData(
            String iconName,
            SObjectDescription description,
            List<FieldDescription> fields
        ) {
            this.iconName = iconName;
            this.description = description;
            this.fields = fields;
        }
    }

    public class SObjectDescription {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String apiName;
        @AuraEnabled
        public String keyPrefix;
        @AuraEnabled
        public Boolean accessible;
        @AuraEnabled
        public Boolean queryable;
        @AuraEnabled
        public Boolean custom;
        @AuraEnabled
        public Boolean updateable;

        public SObjectDescription(
            String label,
            String apiName,
            String keyPrefix,
            Boolean accessible,
            Boolean queryable,
            Boolean custom,
            Boolean updateable
        ) {
            this.label = label;
            this.apiName = apiName;
            this.keyPrefix = keyPrefix;
            this.accessible = accessible;
            this.queryable = queryable;
            this.custom = custom;
            this.updateable = updateable;
        }
    }

    public class FieldDescription {
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String name;
        @AuraEnabled
        public Boolean accessible;
        @AuraEnabled
        public Boolean custom;
        @AuraEnabled
        public Boolean idLookup;
        @AuraEnabled
        public String relationshipName;

        public FieldDescription(
            String label,
            String name,
            Boolean accessible,
            Boolean custom,
            Boolean idLookup,
            String relationshipName
        ) {
            this.label = label;
            this.name = name;
            this.accessible = accessible;
            this.custom = custom;
            this.idLookup = idLookup;
            this.relationshipName = relationshipName;
        }
    }
}
