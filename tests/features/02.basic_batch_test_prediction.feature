Feature: Upload source and produce remote batch test predictions
    In order to produce test predictions
    I need to upload a train set and a test set
    Then I need to create a dataset and a model and a batch prediction to predict


    Scenario: Successfully building test predictions from scratch:
        Given I create BigML resources uploading train "<data>" file to test "<test>" remotely with mapping file "<fields_map>" and log predictions in "<output>"
        And I check that the source has been created
        And I check that the dataset has been created 
        And I check that the model has been created
        And I check that the source has been created from the test file
        And I check that the dataset has been created from the test file
        And I check that the batch prediction has been created
        And I check that the predictions are ready
        Then the local prediction file is like "<predictions_file>"

        Examples:
        | data               | test                    | fields_map | output                        |predictions_file           |
        | ../data/grades.csv | ../data/test_grades.csv | ../data/grades_fields_map.csv | ./scenario_r1_r/predictions.csv | ./check_files/predictions_grades.csv |


    Scenario: Successfully building test predictions from scratch:
        Given I create BigML resources uploading train "<data>" file to test "<test>" remotely and log predictions in "<output>"
        And I check that the source has been created
        And I check that the dataset has been created 
        And I check that the model has been created
        And I check that the source has been created from the test file
        And I check that the dataset has been created from the test file
        And I check that the batch prediction has been created
        And I check that the predictions are ready
        Then the local prediction file is like "<predictions_file>"

        Examples:
        | data               | test                    | output                        |predictions_file           |
        | ../data/iris.csv   | ../data/test_iris.csv   | ./scenario_r1/predictions.csv   | ./check_files/predictions_iris.csv   |



    Scenario: Successfully building test predictions from source
        Given I have previously executed "<scenario>" or reproduce it with arguments <kwargs>
        And I create BigML resources using source to test the previous test source remotely and log predictions in "<output>"
        And I check that the dataset has been created 
        And I check that the model has been created
        And I check that the dataset has been created from the test file
        And I check that the batch prediction has been created
        And I check that the predictions are ready
        Then the local prediction file is like "<predictions_file>"

        Examples:
        |scenario    | kwargs                                                  | test                    | output                        |predictions_file           |
        | scenario_r1| {"data": "../data/iris.csv", "output": "./scenario_r1/predictions.csv", "test": "../data/test_iris.csv"}   | ../data/test_iris.csv   | ./scenario_r2/predictions.csv   | ./check_files/predictions_iris.csv   |

    Scenario: Successfully building test predictions from dataset
        Given I have previously executed "<scenario>" or reproduce it with arguments <kwargs>
        And I create BigML resources using dataset to test the previous test dataset remotely and log predictions in "<output>"
        And I check that the model has been created
        And I check that the batch prediction has been created
        And I check that the predictions are ready
        Then the local prediction file is like "<predictions_file>"

        Examples:
        |scenario    | kwargs                                                  | test                    | output                        |predictions_file           |
        | scenario_r1| {"data": "../data/iris.csv", "output": "./scenario_r1/predictions.csv", "test": "../data/test_iris.csv"}   | ../data/test_iris.csv   | ./scenario_r3/predictions.csv   | ./check_files/predictions_iris.csv   |

    Scenario: Successfully building test predictions from dataset and prediction format info
        Given I have previously executed "<scenario>" or reproduce it with arguments <kwargs>
        And I create BigML resources using a model to test the previous test dataset remotely with prediction headers and fields "<fields>" and log predictions in "<output>"
        And I check that the batch prediction has been created
        And I check that the predictions are ready
        Then the local prediction file is like "<predictions_file>"

        Examples:
        |scenario    | kwargs                                                  | test                    | fields | output                        |predictions_file           |
        | scenario_r1| {"data": "../data/iris.csv", "output": "./scenario_r1/predictions.csv", "test": "../data/test_iris.csv"}   | ../data/test_iris.csv   | sepal length,sepal width | ./scenario_r4/predictions.csv   | ./check_files/predictions_iris_format.csv   |
        
    Scenario: Successfully building remote test predictions from scratch to a dataset:
        Given I create BigML resources uploading train "<data>" file to test "<test>" remotely to a dataset with no CSV output and log resources in "<output_dir>"
        And I check that the source has been created
        And I check that the dataset has been created 
        And I check that the model has been created
        And I check that the source has been created from the test file
        And I check that the dataset has been created from the test file
        And I check that the batch prediction has been created
        Then I check that the batch predictions dataset exists
        And no local CSV file is created

        Examples:
        | data               | test                    | output_dir      |
        | ../data/iris.csv   | ../data/test_iris.csv   | ./scenario_r5   |
