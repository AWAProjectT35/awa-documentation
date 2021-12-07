# Test Plan

**Table of Contents**

* [Introduction](#Introduction)
    * [Scope](#Scope)
    * [Out of scope](#Out-of-scope)
    * [Quality Objective](#Quality-Objective)
    * [Roles and Responsibilities](#Roles-and-Responsibilities)
* [Test Methodology](#Test-Methodology)
    * [Overview](#Overview)
    * [Test levels](#Test-levels)
    * [Bug Triage](#Bug-Triage)
* [Test Deliverables](#Test-Deliverables)

## Introduction


### Scope

The scope of this tests includes all features described in the 
project work instructions [here](https://oamk-my.sharepoint.com/:w:/g/personal/lassehav_oamk_fi/EZEZElaOJsdDkgulKQ4LpF0BfTW-yByp0SdzUKZ1mclqPQ?e=Z48Pnc).

### Out of scope

Not part of this test plan is ensuring interoperability of the 
backend api with other frontend applications than the one developed 
as part of this project.

### Quality Objective

- Ensure the Application Under Test conforms to functional and 
non-functional requirements 
- Only functional code gets deployed to heroku
- The application does not crash under any circumstances

### Roles and Responsibilities

**Test case author**

Defines the test case with all preconditions, inputs, 
instructions and steps to follow to complete the test and 
expected outcomes. Assinges one or two testers to the test case.
The author of a test case can also be a tester.

**Tester**

Runs the test. This includes seting up the preconditions defined 
in the test case, following the given instructions and if the 
test failes file a bug report 
on github. In any case, success or not, the tester notes 
the time and date of testing aswell as the fail/success with 
an optional note below the test case instructions. 

## Test Methodology

### Overview 

The development of the project follows the kanban methodology. 
New features or changes to the application are defined as an 
issue on github and are developed under the responsibility of 
one person. Ideally each issue is developed in its own git 
branch and is only merged into the main branch when it is 
complete and working. 

Due to the kanban approach to development the applications 
constantly change as the endresult is never written in stone. 
According to agile development changes to the specifications and 
requirements are always acceptable when they implrove the overall 
product. Therefore specific test cases can only be written close 
to the end of the project, in a phase where major changes are 
less likely to be necessary. In earlier phases mostly white box 
testing is used to approve to changes.


### Test levels

The following levels/tests exist for this project:

- white box testing
- local testing
- online testing

white box tests are done by reviewing the changes someone made to the code 
and giving feedback. This happens on github when a merge request adds many 
changes or causes issues and the author wishes a review by someone else 
before merging the changes into the main product.

Local testing means testing the application under test running on the 
testers computer. All parts of the application, frontend, backend and 
database are running localy. 

Online testing means testing the application in its deployed state running 
on Heroku, including frontend, backend and database.

### Bug Triage

When a bug is found while following a test case it must be reported on github
as an issue with the label `Bug`. The author of the code that caused the bug 
must be assigned to the issue. Only when the bug is fixxed can the test continue.

## Test Deliverables 

1. Test Plan - this document
2. Test Cases including test results and date of testing
3. Bug Reports on GitHub
4. Comments on merge requests on Github