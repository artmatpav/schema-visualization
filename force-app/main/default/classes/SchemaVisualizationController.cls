public with sharing class SchemaVisualizationController {
    @AuraEnabled
    public static List<SchemaVisualizationData.ComboboxOption> getComboboxOptions() {
        List<SchemaVisualizationData.ComboboxOption> options = new List<SchemaVisualizationData.ComboboxOption>();

        for (SObjectType sobjectType : Schema.getGlobalDescribe().values()) {
            options.add(
                new SchemaVisualizationData.ComboboxOption(
                    sobjectType.getDescribe().label,
                    sobjectType.getDescribe().name
                )
            );
        }

        return options;
    }

    @AuraEnabled
    public static SchemaVisualizationData.SObjectData getSObjectData(
        String sobjectName
    ) {
        String sobjectIconName = getSObjectIconName(sobjectName);

        DescribeSObjectResult describedSObject = Schema.getGlobalDescribe()
            .get(sobjectName)
            .getDescribe();
        SchemaVisualizationData.SObjectDescription sobjectDescription = getSObjectDescription(
            describedSObject
        );
        List<SchemaVisualizationData.FieldDescription> fieldDescriptions = getFieldDescriptions(
            describedSObject
        );
        SchemaVisualizationData.SObjectData sobjectData = new SchemaVisualizationData.SObjectData(
            sobjectIconName,
            sobjectDescription,
            fieldDescriptions
        );

        return sobjectData;
    }

    private static List<SchemaVisualizationData.FieldDescription> getFieldDescriptions(
        DescribeSObjectResult describedSObject
    ) {
        List<SchemaVisualizationData.FieldDescription> fieldDescriptions = new List<SchemaVisualizationData.FieldDescription>();

        for (SObjectField field : describedSObject.fields.getMap().values()) {
            fieldDescriptions.add(
                new SchemaVisualizationData.FieldDescription(
                    field.getDescribe().label,
                    field.getDescribe().name,
                    field.getDescribe().accessible,
                    field.getDescribe().custom,
                    field.getDescribe().idLookup,
                    field.getDescribe().relationshipName
                )
            );
        }

        return fieldDescriptions;
    }

    private static SchemaVisualizationData.SObjectDescription getSObjectDescription(
        DescribeSObjectResult describedSObject
    ) {
        return new SchemaVisualizationData.SObjectDescription(
            describedSObject.label,
            describedSObject.name,
            describedSObject.keyPrefix,
            describedSObject.accessible,
            describedSObject.queryable,
            describedSObject.custom,
            describedSObject.updateable
        );
    }

    private static String getSObjectIconName(String sobjectName) {
        List<Schema.DescribeTabSetResult> tabSetResults = Schema.describeTabs();
        List<Schema.DescribeTabResult> tabResults = new List<Schema.DescribeTabResult>();
        List<Schema.DescribeIconResult> iconResults = new List<Schema.DescribeIconResult>();

        String iconName;

        for (Schema.DescribeTabSetResult tsr : tabSetResults) {
            tabResults.addAll(tsr.getTabs());
        }

        for (Schema.DescribeTabResult tr : tabResults) {
            if (sObjectName == tr.getSobjectName()) {
                if (tr.isCustom() == true) {
                    iconResults.addAll(tr.getIcons());
                } else {
                    iconName = getCombinedIconName(
                        SchemaVisualizationConstants.ICON_PREFIX_STANDARD,
                        sObjectName.toLowerCase()
                    );
                }
            }
        }

        for (Schema.DescribeIconResult iconResult : iconResults) {
            if (iconResult.getContentType() == 'image/svg+xml') {
                iconName = getCombinedIconName(
                    SchemaVisualizationConstants.ICON_PREFIX_CUSTOM,
                    iconResult.getUrl()
                        .substringBetween(
                            SchemaVisualizationConstants.ICON_PREFIX_CUSTOM +
                            '/',
                            '.svg'
                        )
                        .substringBefore('_')
                );

                break;
            }
        }

        return iconName == null
            ? SchemaVisualizationConstants.ICON_NAME_UTILITY_ERROR
            : iconName;
    }

    private static String getCombinedIconName(String prefix, String postfix) {
        return prefix + ':' + postfix;
    }
}
