@isTest
private with sharing class SchemaVisualizationControllerTest {
    @isTest
    static void testGetComboboxOptions() {
        List<SchemaVisualizationData.ComboboxOption> options = SchemaVisualizationController.getComboboxOptions();

        for (SchemaVisualizationData.ComboboxOption option : options) {
            System.assertNotEquals(null, option.label);
            System.assertNotEquals(null, option.value);
        }

        System.assertNotEquals(0, options.size());
    }

    @isTest
    static void testGetSObjectDataWithAccount() {
        checkAsserts('Account');
    }

    @isTest
    static void testGetSObjectDataWithCustomObject() {
        String customObjectName;

        for (SObjectType type : Schema.getGlobalDescribe().values()) {
            if (type.getDescribe().custom) {
                customObjectName = type.getDescribe().name;

                break;
            }
        }

        if (customObjectName != null) {
            checkAsserts(customObjectName);
        }
    }

    private static void checkAsserts(String sobjectName) {
        SchemaVisualizationData.SObjectData sobjectData = SchemaVisualizationController.getSObjectData(
            sobjectName
        );
        DescribeSObjectResult describedSObject = Schema.getGlobalDescribe()
            .get(sobjectName)
            .getDescribe();

        System.assertNotEquals(null, sobjectData.iconName);
        System.assertEquals(
            describedSObject.label,
            sobjectData.description.label
        );
        System.assertEquals(
            describedSObject.name,
            sobjectData.description.apiName
        );
        System.assertEquals(
            describedSObject.keyPrefix,
            sobjectData.description.keyPrefix
        );
        System.assertEquals(
            describedSObject.accessible,
            sobjectData.description.accessible
        );
        System.assertEquals(
            describedSObject.queryable,
            sobjectData.description.queryable
        );
        System.assertEquals(
            describedSObject.custom,
            sobjectData.description.custom
        );
        System.assertEquals(
            describedSObject.updateable,
            sobjectData.description.updateable
        );
        System.assertNotEquals(0, sobjectData.fields.size());
    }
}
