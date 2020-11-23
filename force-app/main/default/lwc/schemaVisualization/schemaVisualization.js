import { LightningElement, track } from "lwc";
import getComboboxOptions from "@salesforce/apex/SchemaVisualizationController.getComboboxOptions";
import getSObjectData from "@salesforce/apex/SchemaVisualizationController.getSObjectData";

export default class SchemaVisualization extends LightningElement {
    selectedSObject = "";
    sobjectIcon;
    @track comboboxOptions;
    @track sobjectDescription;
    @track columns;
    @track data;

    connectedCallback() {
        getComboboxOptions()
            .then((comboboxOptions) => {
                this.comboboxOptions = comboboxOptions;
            })
            .catch((error) => {
                console.error("Retrieve SObject Labels Error:", error);
            });
    }

    get options() {
        return this.comboboxOptions;
    }

    handleSObjectSelection(event) {
        this.selectedSObject = event.detail.value;

        getSObjectData({
            sobjectName: this.selectedSObject
        })
            .then((sobjectData) => {
                this.iconName = sobjectData.iconName;

                this.sobjectDescription = Object.keys(
                    sobjectData.description
                ).map((key) => {
                    return {
                        label: this.setFirstLetterToUpperCase(key),
                        value: sobjectData.description[key]
                    };
                });

                this.columns = Object.keys(sobjectData.fields[0]).map((key) => {
                    return {
                        label: this.setFirstLetterToUpperCase(key),
                        fieldName: key
                    };
                });

                this.data = sobjectData.fields;
            })
            .catch((error) => {
                console.error("Retrieve SObject Data Error:", error);
            });
    }

    setFirstLetterToUpperCase(value) {
        return value.charAt(0).toUpperCase() + value.slice(1);
    }
}
