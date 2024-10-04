// table 61188 "HRM-Employee C"
// {
//     Caption = 'Employee';
//     DataCaptionFields = "No.", "Job Title", "First Name", "Middle Name", "Last Name", "Search Name";
//     Description = 'Employees';
//     // DrillDownPageID = "Emp. List";
//     // LookupPageID = "Emp. List";

//     fields
//     {
//         field(1; "No."; Code[20])
//         {
//             NotBlank = false;

//             trigger OnValidate()
//             begin
//                 /*
//                 IF "No." <> xRec."No." THEN BEGIN
//                   HumanResSetup.GET;
//                   NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
//                   "No. Series" := '';
//                 END;
//                 */
//                 //This is for staff to Library Dataport don't Delete!
//                 if "No." <> '' then
//                     Category := 'STAFF';

//             end;
//         }
//         field(2; "First Name"; Text[30])
//         {
//         }
//         field(3; "Middle Name"; Text[30])
//         {
//         }
//         field(4; "Last Name"; Text[30])
//         {

//             trigger OnValidate()
//             var
//                 Reason: Text[30];
//             begin
//                 /*  IF (("Last Name" <> xRec."Last Name") AND  (xRec."Last Name" <> ''))  THEN BEGIN
//                      CareerEvent.SetMessage('Changing Surname in Career History');
//                      CareerEvent.RUNMODAL;
//                      OK:= CareerEvent.ReturnResult;
//                       IF OK THEN BEGIN
//                          IF NOT CareerHistory.FIND('-') THEN
//                           CareerHistory."Line No.":=1
//                         ELSE BEGIN
//                           CareerHistory.FIND('+');
//                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                         END;

//                          CareerHistory.INIT;
//                          CareerHistory.Reason := CareerEvent.ReturnReason;
//                          CareerHistory."Employee No.":= "No.";
//                          CareerHistory."Date Of Event":= WORKDATE;
//                          CareerHistory."Career Event":= 'Surname Changed';
//                          CareerHistory."Last Name":= "Last Name";
//                          CareerHistory."Employee First Name":= "Known As";
//                          CareerHistory."Employee Last Name":= "Last Name";
//                          CareerHistory.INSERT;
//                       END;
//                   END;

//                    */

//                 Names := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";

//             end;
//         }
//         field(5; Initials; Text[30])
//         {
//             //TableRelation = "HRM-Staff Title".Code;

//             trigger OnValidate()
//             begin
//                 if ("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '') then
//                     "Search Name" := Initials;
//             end;
//         }
//         field(7; "Search Name"; Code[50])
//         {
//         }
//         field(8; "Postal Address"; Text[50])
//         {
//         }
//         field(9; "Residential Address"; Text[50])
//         {
//         }
//         field(10; City; Text[30])
//         {

//             trigger OnValidate()
//             begin
//                 /* IF (City <> xRec.City) THEN BEGIN
//                      CareerEvent.SetMessage('Location Changed');
//                      CareerEvent.RUNMODAL;
//                      OK:= CareerEvent.ReturnResult;
//                       IF OK THEN BEGIN
//                          IF NOT CareerHistory.FIND('-') THEN
//                           CareerHistory."Line No.":=1
//                         ELSE BEGIN
//                           CareerHistory.FIND('+');
//                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                         END;

//                          CareerHistory.INIT;
//                          CareerHistory."Employee No.":= "No.";
//                          CareerHistory."Date Of Event":= WORKDATE;
//                          CareerHistory."Career Event":= 'Location Changed';
//                          CareerHistory.Location:= City;
//                          CareerHistory."Employee First Name":= "Known As";
//                          CareerHistory."Employee Last Name":= "Last Name";
//                          CareerHistory.INSERT;
//                       END;
//                  END;*/

//             end;
//         }
//         field(11; "Post Code"; Code[20])
//         {
//             TableRelation = "Post Code";
//             //This property is currently not supported
//             //TestTableRelation = false;
//             ValidateTableRelation = false;

//             trigger OnValidate()
//             begin
//                 if PostCode.Get("Post Code") then
//                     City := PostCode.City;
//                 /* IF ((City <> xRec.City) AND  (xRec.City <> ''))  THEN BEGIN
//                     CareerEvent.SetMessage('Location Changed');
//                     CareerEvent.RUNMODAL;
//                     OK:= CareerEvent.ReturnResult;
//                      IF OK THEN BEGIN
//                         IF NOT CareerHistory.FIND('-') THEN
//                          CareerHistory."Line No.":=1
//                        ELSE BEGIN
//                          CareerHistory.FIND('+');
//                          CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                        END;

//                         CareerHistory.INIT;
//                         CareerHistory."Employee No.":= "No.";
//                         CareerHistory."Date Of Event":= WORKDATE;
//                         CareerHistory."Career Event":= 'Location Changed';
//                         CareerHistory.Location:= City;
//                         CareerHistory."Employee First Name":= "Known As";
//                         CareerHistory."Employee Last Name":= "Last Name";
//                         CareerHistory.INSERT;
//                      END;
//                 END;  */

//             end;
//         }
//         field(12; County; Text[30])
//         {
//         }
//         field(13; "Home Phone Number"; Text[30])
//         {
//         }
//         field(14; "Cellular Phone Number"; Text[30])
//         {
//         }
//         field(15; "Work Phone Number"; Text[30])
//         {
//         }
//         field(16; "Ext."; Text[20])
//         {
//         }
//         field(17; "E-Mail"; Text[100])
//         {
//         }
//         field(19; Picture; BLOB)
//         {
//             SubType = Bitmap;
//         }
//         field(21; "ID Number"; Text[30])
//         {
//         }
//         field(22; "Union Code"; Code[20])
//         {
//             TableRelation = Union;
//         }
//         field(23; "UIF Number"; Text[30])
//         {
//         }
//         field(24; Gender; Option)
//         {
//             OptionMembers = Female,Male;
//         }
//         field(25; "Country Code"; Code[20])
//         {
//             TableRelation = "Country/Region";
//         }
//         field(28; "Statistics Group Code"; Code[20])
//         {
//             TableRelation = "Employee Statistics Group";
//         }
//         field(31; Status; Option)
//         {
//             OptionCaption = 'Active,Inactive';
//             OptionMembers = Active,Inactive;

//             trigger OnValidate()
//             begin
//                 /*  IF (Status <> xRec.Status) THEN BEGIN
//                      IF (Status = Status::"5") THEN
//                         Disabled := Disabled::Yes;

//                      CareerEvent.SetMessage('Status Changed');
//                      CareerEvent.RUNMODAL;
//                      OK:= CareerEvent.ReturnResult;
//                       IF OK THEN BEGIN
//                          IF NOT CareerHistory.FIND('-') THEN
//                           CareerHistory."Line No.":=1
//                         ELSE BEGIN
//                           CareerHistory.FIND('+');
//                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                         END;

//                          CareerHistory.INIT;
//                          CareerHistory."Employee No.":= "No.";
//                          CareerHistory."Date Of Event":= WORKDATE;
//                          CareerHistory."Career Event":= 'Status Changed';
//                          CareerHistory.Status:= Status;
//                          CareerHistory."Employee First Name":= "Known As";
//                          CareerHistory."Employee Last Name":= "Last Name";
//                          CareerHistory.INSERT;
//                       END;
//                   END;
//                    */

//             end;
//         }
//         field(36; "Department Code"; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));

//             trigger OnValidate()
//             begin
//                 /*
//                  { IF (("Department Code" <> xRec."Department Code") AND (xRec."Department Code" <> '')) THEN BEGIN
//                       CareerEvent.SetMessage('Department Changed');
//                       CareerEvent.RUNMODAL;
//                       OK:= CareerEvent.ReturnResult;
//                        IF OK THEN BEGIN
//                           IF NOT CareerHistory.FIND('-') THEN
//                            CareerHistory."Line No.":=1
//                          ELSE BEGIN
//                            CareerHistory.FIND('+');
//                            CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                          END;
//                           CareerHistory.INIT;
//                           CareerHistory."Employee No.":= "No.";
//                           CareerHistory."Date Of Event":= WORKDATE;
//                           CareerHistory."Career Event":= 'Department Changed';
//                           CareerHistory.Department:="Department Code";
//                           CareerHistory."Employee First Name":= "Known As";
//                           CareerHistory."Employee Last Name":= "Last Name";
//                           CareerHistory.INSERT;
//                        END;
//                      //  Code below commented by Linus
//                       {
//                        IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
//                          EmployeeResUpdate.ResUpdate(Rec)
//                       }
//                    END;
//                 }
//                //Added to change dept on employee table and assignment matrix table
//                //employee payroll
//                IF Payroll.GET("No.") THEN BEGIN
//                Payroll."Department Code":="Department Code";
//                Payroll.MODIFY;
//                END;

//                //
//                 GetPayPeriod;
//                // "Payroll Period":=PayStartDate;
//                //  "Pay Period":=PayPeriodText;

//                //Employee No,Type,Code,Payroll Period,Department Code


//                AssMatrix.RESET;
//                AssMatrix.SETRANGE(AssMatrix."Employee No","No.");
//                AssMatrix.SETRANGE("Payroll Period",PayStartDate);
//                IF AssMatrix.FIND('-') THEN BEGIN
//                 REPEAT
//                  AssMatrixTemp.TRANSFERFIELDS(AssMatrix);
//                  AssMatrixTemp."Department Code":="Department Code";
//                  AssMatrixTemp.INSERT;
//                  AssMatrix.DELETE;
//                 UNTIL AssMatrix.NEXT=0;
//                END;


//                AssMatrixTemp.RESET;
//                AssMatrixTemp.SETRANGE(AssMatrixTemp."Employee No","No.");
//                AssMatrixTemp.SETRANGE("Payroll Period",PayStartDate);
//                IF AssMatrixTemp.FIND('-') THEN BEGIN
//                 REPEAT
//                  AssMatrix.TRANSFERFIELDS(AssMatrixTemp);
//                  //AssMatrix."Department Code":="Department Code";
//                  AssMatrix.INSERT;
//                 AssMatrixTemp.DELETE;
//                 UNTIL AssMatrixTemp.NEXT=0;
//                END;
//                 */

//             end;
//         }
//         field(37; Office; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('BRANCH'));

//             trigger OnValidate()
//             begin
//                 //IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
//                 //  EmployeeResUpdate.ResUpdate(Rec)
//             end;
//         }
//         field(38; "Resource No."; Code[20])
//         {
//             TableRelation = Resource;

//             trigger OnValidate()
//             begin
//                 //IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
//                 //  EmployeeResUpdate.ResUpdate(Rec)
//             end;
//         }
//         field(39; Comment; Boolean)
//         {
//             Editable = false;
//         }
//         field(40; "Last Date Modified"; Date)
//         {
//             Editable = false;
//         }
//         field(41; "Date Filter"; Date)
//         {
//             FieldClass = FlowFilter;
//         }
//         field(42; "Department Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
//         }
//         field(43; "Office Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
//         }
//         field(47; "Employee No. Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             TableRelation = Employee;
//         }
//         field(49; "Fax Number"; Text[30])
//         {
//         }
//         field(50; "Company E-Mail"; Text[60])
//         {
//         }
//         field(51; Title; Option)
//         {
//             OptionCaption = 'MR,MRS,MISS,MS,DR.,  ,CC,ASSCOC.PROF,PROF.';
//             OptionMembers = "MR.","MRS.","MISS.","MS.","DR.","  ",CC,"ASSCOC.PROF","PROF.",PROF;

//             trigger OnValidate()
//             begin
//                 /*  IF (Title <> xRec.Title) THEN BEGIN
//                      CareerEvent.SetMessage('Title Changed');
//                      CareerEvent.RUNMODAL;
//                      OK:= CareerEvent.ReturnResult;
//                       IF OK THEN BEGIN
//                          IF NOT CareerHistory.FIND('-') THEN
//                           CareerHistory."Line No.":=1
//                         ELSE BEGIN
//                           CareerHistory.FIND('+');
//                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                         END;

//                          CareerHistory.INIT;
//                          CareerHistory."Employee No.":= "No.";
//                          CareerHistory."Date Of Event":= WORKDATE;
//                          CareerHistory."Career Event":= 'Title Changed';
//                          CareerHistory.Title:= Title;
//                          CareerHistory."Employee First Name":= "Known As";
//                          CareerHistory."Employee Last Name":= "Last Name";
//                          CareerHistory.INSERT;
//                       END;
//                   END;*/

//             end;
//         }
//         field(52; "Salespers./Purch. Code"; Code[20])
//         {

//             trigger OnValidate()
//             begin
//                 // if ("Salespers./Purch. Code" <> '') and SalespersonPurchaser.WritePermission then
//                 //EmployeeSalespersonUpdate.SalesPersonUpdate(Rec)
//             end;
//         }
//         field(53; "No. Series"; Code[20])
//         {
//             Editable = false;
//             TableRelation = "No. Series";
//         }
//         field(54; "Known As"; Text[30])
//         {

//             trigger OnValidate()
//             begin
//                 /*IF (("Known As" <> xRec."Known As") AND  (xRec."Known As" <> ''))  THEN BEGIN
//                        CareerEvent.SetMessage('Changing First Name in Career History');
//                        CareerEvent.RUNMODAL;
//                        OK:= CareerEvent.ReturnResult;
//                         IF OK THEN BEGIN
//                            CareerHistory.INIT;
//                            IF NOT CareerHistory.FIND('-') THEN
//                             CareerHistory."Line No.":=1
//                           ELSE BEGIN
//                             CareerHistory.FIND('+');
//                             CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                           END;

//                            CareerHistory.Reason := CareerEvent.ReturnReason;
//                            CareerHistory."Employee No.":= "No.";
//                            CareerHistory."Date Of Event":= WORKDATE;
//                            CareerHistory."Career Event":= 'Surname Changed';
//                            CareerHistory."Last Name":= "Last Name";
//                            CareerHistory."Employee First Name":= "Known As";
//                            CareerHistory."Employee Last Name":= "Last Name";

//                            CareerHistory.INSERT;
//                         END;
//                     END;  */

//             end;
//         }
//         field(55; Position; Text[80])
//         {
//             // TableRelation = "HRM-Company Jobs"."Job ID";

//             trigger OnValidate()
//             begin
//                 /*
//                     IF ((Position <> xRec.Position) AND (xRec.Position <> '')) THEN BEGIN
//                       Jobs.RESET;
//                       Jobs.SETRANGE(Jobs."Job ID",Position);
//                       IF Jobs.FIND('-') THEN BEGIN
//                           Payroll.RESET;
//                           Payroll.SETRANGE(Payroll.Code,"No.");
//                           IF Payroll.FIND('-') THEN BEGIN
//                               Payroll."Salary Scheme Category":=Jobs.Category;
//                               Payroll."Salary Steps":=Jobs.Grade;
//                               Payroll.VALIDATE(Payroll."Salary Steps");
//                               Payroll.MODIFY;
//                           END
//                       END



//                         {
//                       CareerEvent.SetMessage('Job Title Changed');
//                      CareerEvent.RUNMODAL;
//                      OK:= CareerEvent.ReturnResult;
//                       IF OK THEN BEGIN
//                          CareerHistory.INIT;
//                          IF NOT CareerHistory.FIND('-') THEN
//                           CareerHistory."Line No.":=1
//                         ELSE BEGIN
//                           CareerHistory.FIND('+');
//                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                         END;

//                          CareerHistory."Employee No.":= "No.";
//                          CareerHistory."Date Of Event":= WORKDATE;
//                          CareerHistory."Career Event":= 'Job Title Changed';
//                          CareerHistory."Job Title":= "Position Title";
//                          CareerHistory."Employee First Name":= "Known As";
//                          CareerHistory."Employee Last Name":= "Last Name";
//                          CareerHistory.INSERT;
//                       END;
//                       }

//                   END;
//                */

//             end;
//         }
//         field(57; "Full / Part Time"; Option)
//         {
//             OptionMembers = "Full Time"," Part Time",Contract;

//             trigger OnValidate()
//             begin
//                 /* IF ("Full / Part Time" <> xRec."Full / Part Time") THEN BEGIN
//                     CareerEvent.SetMessage('Full / Part Time Changed');
//                     CareerEvent.RUNMODAL;
//                     OK:= CareerEvent.ReturnResult;
//                      IF OK THEN BEGIN
//                         CareerHistory.INIT;
//                         IF NOT CareerHistory.FIND('-') THEN
//                          CareerHistory."Line No.":=1
//                        ELSE BEGIN
//                          CareerHistory.FIND('+');
//                          CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                        END;

//                         CareerHistory."Employee No.":= "No.";
//                         CareerHistory."Date Of Event":= WORKDATE;
//                         CareerHistory."Career Event":= 'Full / Part Time Changed';
//                         CareerHistory."Full/Part Time":= "Full / Part Time";
//                         CareerHistory."Employee First Name":= "Known As";
//                         CareerHistory."Employee Last Name":= "Last Name";
//                         CareerHistory.INSERT;
//                      END;
//                  END;*/

//             end;
//         }
//         field(58; "Contract Type"; Code[50])
//         {
//             // TableRelation = "HRM-Contract Types".Contract;
//         }
//         field(59; "Contract End Date"; Date)
//         {
//         }
//         field(60; "Notice Period"; Code[20])
//         {
//             //TableRelation = "REG-Registry Cue"."Primary Key";
//         }
//         field(61; "Union Member?"; Boolean)
//         {
//         }
//         field(62; "Shift Worker?"; Boolean)
//         {
//         }
//         field(63; "Contracted Hours"; Decimal)
//         {
//         }
//         field(64; "Pay Period"; Option)
//         {
//             OptionMembers = Weekly,"2 Weekly","4 Weekly",Monthly," ";
//         }
//         field(65; "Pay Per Period"; Decimal)
//         {
//         }
//         field(66; "Cost Code"; Code[20])
//         {
//             //TableRelation = Table39005630;

//             trigger OnValidate()
//             begin
//                 CurrentPayDetails;
//             end;
//         }
//         field(68; "PAYE Number"; Text[30])
//         {
//         }
//         field(69; "UIF Contributor?"; Boolean)
//         {
//         }
//         field(73; "Marital Status"; Option)
//         {
//             OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;

//             trigger OnValidate()
//             begin
//                 /*  IF ("Marital Status" <> xRec."Marital Status") THEN BEGIN
//                      CareerEvent.SetMessage('Marital Status Changed');
//                      CareerEvent.RUNMODAL;
//                      OK:= CareerEvent.ReturnResult;
//                       IF OK THEN BEGIN
//                          CareerHistory.INIT;
//                          IF NOT CareerHistory.FIND('-') THEN
//                           CareerHistory."Line No.":=1
//                         ELSE BEGIN
//                           CareerHistory.FIND('+');
//                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                         END;

//                          CareerHistory."Employee No.":= "No.";
//                          CareerHistory."Date Of Event":= WORKDATE;
//                          CareerHistory."Career Event":= 'Marital Status Changed';
//                          CareerHistory."Marital Status":= "Marital Status";
//                          CareerHistory."Employee First Name":= "Known As";
//                          CareerHistory."Employee Last Name":= "Last Name";
//                          CareerHistory.INSERT;
//                       END;
//                   END;  */

//             end;
//         }
//         field(74; "Ethnic Origin"; Option)
//         {
//             OptionMembers = African,Indian,White,Coloured;

//             trigger OnValidate()
//             begin
//                 /*     EmployeeEquity.SETRANGE("Employee No.","No.");
//                      OK:= EmployeeEquity.FIND('-');
//                      IF OK THEN BEGIN
//                        EmployeeEquity."Middle Name":= "Ethnic Origin";
//                        EmployeeEquity.MODIFY;
//                      END;
//                           */

//             end;
//         }
//         field(75; "First Language (R/W/S)"; Code[20])
//         {
//             //TableRelation = "HRM-Language Preference";
//         }
//         field(76; "Driving Licence"; Code[20])
//         {
//             //TableRelation = "HRM-Job Responsiblities (B)";
//         }
//         field(77; "Vehicle Registration Number"; Code[20])
//         {

//             trigger OnValidate()
//             begin
//                 /* IF ("Vehicle Registration Number" <> xRec."Vehicle Registration Number") AND ("Vehicle Registration Number" <> '') THEN BEGIN
//                     CareerEvent.SetMessage('Vehicle Registration Number Changed');
//                     CareerEvent.RUNMODAL;
//                     OK:= CareerEvent.ReturnResult;
//                      IF OK THEN BEGIN
//                         CareerHistory.INIT;
//                         IF NOT CareerHistory.FIND('-') THEN
//                          CareerHistory."Line No.":=1
//                        ELSE BEGIN
//                          CareerHistory.FIND('+');
//                          CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                        END;

//                         CareerHistory."Employee No.":= "No.";
//                         CareerHistory."Date Of Event":= WORKDATE;
//                         CareerHistory."Career Event":= 'Vehicle Registration Number Changed';
//                         CareerHistory."Vehicle Registration":= "Vehicle Registration Number";
//                         CareerHistory."Employee First Name":= "Known As";
//                         CareerHistory."Employee Last Name":= "Last Name";
//                         CareerHistory.INSERT;
//                      END;
//                  END; */

//             end;
//         }
//         field(78; Disabled; Option)
//         {
//             OptionMembers = No,Yes," ";

//             trigger OnValidate()
//             begin
//                 if (Disabled = Disabled::Yes) then
//                     Status := Status::Inactive
//             end;
//         }
//         field(79; "Health Assesment?"; Boolean)
//         {
//         }
//         field(80; "Health Assesment Date"; Date)
//         {
//         }
//         field(81; "Date Of Birth"; Date)
//         {
//         }
//         field(82; Age; Text[40])
//         {
//         }
//         field(83; "Date Of Join"; Date)
//         {

//             trigger OnValidate()
//             begin
//                 // if (("Date Of Birth" <> 0D) and ("Date Of Join" <> 0D)) then begin
//                 //    // Age := Dates.DetermineAge("Date Of Birth", "Date Of Join");
//                 // end;
//                 // if ("Date Of Leaving" <> 0D) and ("Date Of Join" <> 0D) then
//                 // "Length Of Service" := Dates.DetermineAge("Date Of Join", "Date Of Leaving");

//                 //    IF ("Date Of Join" <> 0D) THEN BEGIN
//                 //       CareerEvent.SetMessage('Joined The Company');
//                 //       CareerEvent.RUNMODAL;
//                 //       OK:= CareerEvent.ReturnResult;
//                 //        IF OK THEN BEGIN
//                 //           CareerHistory.INIT;
//                 //           CareerHistory."Employee No.":= "No.";
//                 //           CareerHistory."Date Of Event":= "Date Of Join";
//                 //           CareerHistory."Career Event":= 'Joined The Company';
//                 //           CareerHistory.Joined:= TRUE;
//                 //           CareerHistory."Employee First Name":= "Known As";
//                 //           CareerHistory."Employee Last Name":= "Last Name";
//                 //           CareerHistory.INSERT;
//                 //        END;
//                 // END;
//             end;
//         }
//         field(84; "Length Of Service"; Text[50])
//         {
//         }
//         field(85; "End Of Probation Date"; Date)
//         {
//         }
//         field(86; "Pension Scheme Join"; Date)
//         {

//             trigger OnValidate()
//             begin
//                 // IF ("Date Of Leaving" <> 0D) AND ("Pension Scheme Join" <> 0D) THEN
//                 //  "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
//             end;
//         }
//         field(87; "Time Pension Scheme"; Text[50])
//         {
//         }
//         field(88; "Medical Scheme Join"; Date)
//         {

//             trigger OnValidate()
//             begin
//                 //  IF  ("Date Of Leaving" <> 0D) AND ("Medical Scheme Join" <> 0D) THEN
//                 //  "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
//             end;
//         }
//         field(89; "Time Medical Scheme"; Text[20])
//         {
//             //This property is currently not supported
//             //TestTableRelation = true;
//             //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
//             //ValidateTableRelation = true;
//         }
//         field(90; "Date Of Leaving"; Date)
//         {

//             trigger OnValidate()
//             begin
//                 /*   IF ("Date Of Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
//                     "Length Of Service":= Dates.DetermineAge("Date Of Join","Date Of Leaving");
//                    IF ("Pension Scheme Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
//                     "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
//                    IF ("Medical Scheme Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
//                     "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");


//                    IF ("Date Of Leaving" <> 0D) AND ("Date Of Leaving" <> xRec."Date Of Leaving") THEN BEGIN
//                       ExitInterviews.SETRANGE("Employee No.","No.");
//                       OK:= ExitInterviews.FIND('-');
//                       COMMIT();
//                    END;


//                   IF ("Date Of Leaving" <> 0D) AND ("Date Of Leaving" <> xRec."Date Of Leaving") THEN BEGIN
//                     // CareerEvent.SetMessage('Left The Company');
//                    //  CareerEvent.RUNMODAL;
//                     // OK:= CareerEvent.ReturnResult;
//                       IF OK THEN BEGIN
//                        {  CareerHistory.INIT;
//                          IF NOT CareerHistory.FIND('-') THEN
//                           CareerHistory."Line No.":=1
//                         ELSE BEGIN
//                           CareerHistory.FIND('+');
//                           CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                         END;
//                        }
//                       //   CareerHistory."Employee No.":= "No.";
//                       //   CareerHistory."Date Of Event":= "Date Of Leaving";
//                       //   CareerHistory."Career Event":= 'Left The Company';
//                       //   CareerHistory."Employee First Name":= "Known As";
//                        //  CareerHistory."Employee Last Name":= "Last Name";

//                         // CareerHistory.INSERT;
//                       END;
//                   END;
//                   */

//             end;
//         }
//         field(91; Paterson; Code[20])
//         {
//             //TableRelation = "HRM-Overall Comments"."Appraisal Code";
//         }
//         field(92; Peromnes; Code[20])
//         {
//             //TableRelation = "HRM-Jobs";
//         }
//         field(93; Hay; Code[20])
//         {
//             // TableRelation = "HRM-Goal Setting Objective"."Appraisal Code";
//         }
//         field(94; Castellion; Code[20])
//         {
//             //TableRelation = "HRM-Interpersonal Factors"."Appraisal Code";
//         }
//         field(95; "Per Annum"; Decimal)
//         {
//         }
//         field(96; "Allow Overtime"; Option)
//         {
//             OptionMembers = Yes,No," ";
//         }
//         field(97; "Medical Scheme No."; Text[30])
//         {

//             trigger OnValidate()
//             begin
//                 //MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 // OK := MedicalAidBenefit.FIND('+');
//                 //IF OK THEN BEGIN
//                 // REPEAT
//                 //  MedicalAidBenefit."Medical Aid Number":= "Medical Aid Number";
//                 //   MedicalAidBenefit.MODIFY;
//                 //   COMMIT();
//                 //UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;

//                 if ("Medical Scheme No." <> xRec."Medical Scheme No.") and ("Medical Scheme No." <> '') then begin
//                     // CareerEvent.SetMessage('Medical Aid Number Changed');
//                     // CareerEvent.RUNMODAL;
//                     // OK:= CareerEvent.ReturnResult;
//                     if OK then begin
//                         /*  CareerHistory.INIT;
//                           IF NOT CareerHistory.FIND('-') THEN
//                            CareerHistory."Line No.":=1
//                          ELSE BEGIN
//                            CareerHistory.FIND('+');
//                            CareerHistory."Line No.":=CareerHistory."Line No."+1;
//                          END;

//                           CareerHistory."Employee No.":= "No.";
//                           CareerHistory."Date Of Event":= WORKDATE;
//                           CareerHistory."Career Event":= 'Medical Aid Number Changed';
//                           CareerHistory."Medical Aid Number":= "Medical Scheme No.";
//                           CareerHistory."Employee First Name":= "Known As";
//                           CareerHistory."Employee Last Name":= "Last Name";
//                           CareerHistory.INSERT;*/
//                     end;
//                 end;

//             end;
//         }
//         field(98; "Medical Scheme Head Member"; Text[20])
//         {

//             trigger OnValidate()
//             begin
//                 //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //   OK := MedicalAidBenefit.FIND('+');
//                 //  IF OK THEN BEGIN
//                 //  REPEAT
//                 //   MedicalAidBenefit."Medical Aid Head Member":= "Medical Aid Head Member";
//                 //    MedicalAidBenefit.MODIFY;
//                 //  UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;
//             end;
//         }
//         field(99; "Number Of Dependants"; Integer)
//         {

//             trigger OnValidate()
//             begin
//                 // MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 // OK := MedicalAidBenefit.FIND('+');
//                 // IF OK THEN BEGIN
//                 //REPEAT
//                 //  MedicalAidBenefit."Number Of Dependants":= "Number Of Dependants";
//                 //  MedicalAidBenefit.MODIFY;
//                 //UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;
//             end;
//         }
//         field(100; "Medical Scheme Name"; Text[30])
//         {
//             //TableRelation = "GEN-Medical Scheme"."Medical Scheme";

//             trigger OnValidate()
//             begin
//                 //MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //OK := MedicalAidBenefit.FIND('+');
//                 //IF OK THEN BEGIN
//                 // REPEAT
//                 // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
//                 //  MedicalAidBenefit.MODIFY;
//                 // UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;
//             end;
//         }
//         field(101; "Amount Paid By Employee"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //  OK := MedicalAidBenefit.FIND('+');
//                 //   IF OK THEN BEGIN
//                 //     REPEAT
//                 //      MedicalAidBenefit."Amount Paid By Employee":= "Amount Paid By Employee";
//                 //       MedicalAidBenefit.MODIFY;
//                 //     UNTIL MedicalAidBenefit.NEXT = 0;
//                 //    END;
//             end;
//         }
//         field(102; "Amount Paid By Company"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 //  MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //   OK := MedicalAidBenefit.FIND('+');
//                 //  IF OK THEN BEGIN
//                 // REPEAT
//                 //      MedicalAidBenefit."Amount Paid By Company":= "Amount Paid By Company";
//                 //      MedicalAidBenefit.MODIFY;
//                 // UNTIL MedicalAidBenefit.NEXT = 0;
//                 //   END;
//             end;
//         }
//         field(103; "Pension Cleared"; Boolean)
//         {
//         }
//         field(104; "Second Language (R/W/S)"; Code[20])
//         {
//             // TableRelation = "HRM-Language Preference".Code;
//         }
//         field(105; "Additional Language"; Code[20])
//         {
//             // TableRelation = "HRM-Language Preference".Code;
//         }
//         field(106; Cleared; Boolean)
//         {
//         }
//         field(107; "Notice Period Days Served"; Decimal)
//         {
//             DecimalPlaces = 0 : 0;
//         }
//         field(108; "UIF Country"; Code[20])
//         {
//             TableRelation = "Country/Region".Code;
//         }
//         field(109; "Notice Period Served"; Option)
//         {
//             OptionCaption = ' ,Fully,Partially';
//             OptionMembers = " ",Fully,Partially;
//         }
//         field(110; "Primary Skills Category"; Option)
//         {
//             OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;

//             trigger OnValidate()
//             begin
//                 //IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
//                 // EmployeeResUpdate.ResUpdate(Rec)
//             end;
//         }
//         field(111; Level; Option)
//         {
//             OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";

//             trigger OnValidate()
//             begin
//                 //IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
//                 // EmployeeResUpdate.ResUpdate(Rec)
//             end;
//         }
//         field(112; "Termination Category"; Option)
//         {
//             OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Deceased,Termination,"Contract Ended",Abscondment,"Appt. Revoked","Contract Termination",Retrenchment,Other;

//             trigger OnValidate()
//             var
//                 "Lrec Resource": Record Resource;
//                 OK: Boolean;
//             begin
//                 //**Added by ACR 12/08/2002
//                 //**Block resource if Terminated

//                 if "Resource No." <> '' then begin
//                     OK := "Lrec Resource".Get("Resource No.");
//                     "Lrec Resource".Blocked := true;
//                     //   "Lrec Resource".MODIFY;
//                 end;

//                 //**
//             end;
//         }
//         field(113; "Job Specification"; Code[20])
//         {
//         }
//         field(114; DateOfBirth; Text[8])
//         {
//         }
//         field(115; DateEngaged; Text[8])
//         {
//         }
//         field(116; "Postal Address2"; Text[50])
//         {
//         }
//         field(117; "Postal Address3"; Text[20])
//         {
//         }
//         field(118; "Residential Address2"; Text[30])
//         {
//         }
//         field(119; "Residential Address3"; Text[20])
//         {
//         }
//         field(120; "Post Code2"; Code[20])
//         {
//             TableRelation = "Post Code";
//         }
//         field(121; Citizenship; Code[20])
//         {
//             TableRelation = "Country/Region".Code;
//         }
//         field(122; "Name Of Manager"; Text[45])
//         {
//         }
//         field(123; "User ID"; Code[20])
//         {
//             TableRelation = "User Setup"."User ID";
//             //This property is currently not supported
//             //TestTableRelation = true;

//             trigger OnValidate()
//             begin
//                 //IF ("User ID" <> '') AND User.WRITEPERMISSION THEN
//                 // EmployeeResUpdate.UserUpdate(Rec)
//             end;
//         }
//         field(124; "Disabling Details"; Text[50])
//         {
//         }
//         field(125; "Disability Grade"; Text[30])
//         {
//         }
//         field(126; "Passport Number"; Text[30])
//         {
//         }
//         field(127; "2nd Skills Category"; Option)
//         {
//             OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
//         }
//         field(128; "3rd Skills Category"; Option)
//         {
//             OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
//         }
//         field(129; PensionJoin; Text[8])
//         {
//         }
//         field(130; DateLeaving; Text[30])
//         {
//         }
//         field(131; Region; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('REGION'));
//         }
//         field(132; "Manager Emp No"; Code[30])
//         {
//             TableRelation = "HRM-Employee C"."No.";

//             trigger OnValidate()
//             begin
//                 emps.Reset;
//                 emps.SetRange(emps."No.", "Manager Emp No");
//                 if emps.Find('-') then begin
//                     "Name Of Manager" := emps."First Name" + ' ' + emps."Middle Name" + ' ' + emps."Last Name";
//                 end;
//             end;
//         }
//         field(133; Temp; Text[30])
//         {
//         }
//         field(134; "Employee Qty"; Integer)
//         {
//             CalcFormula = Count("HRM-Employee C");
//             FieldClass = FlowField;
//         }
//         field(135; "Employee Act. Qty"; Integer)
//         {
//             CalcFormula = Count("HRM-Employee C" WHERE("Termination Category" = FILTER(= " ")));
//             FieldClass = FlowField;
//         }
//         field(136; "Employee Arc. Qty"; Integer)
//         {
//             CalcFormula = Count("HRM-Employee C" WHERE("Termination Category" = FILTER(<> " ")));
//             FieldClass = FlowField;
//         }
//         field(137; "Contract Location"; Text[20])
//         {
//             Description = 'Location where contract was closed';
//         }
//         field(138; "First Language Read"; Boolean)
//         {
//         }
//         field(139; "First Language Write"; Boolean)
//         {
//         }
//         field(140; "First Language Speak"; Boolean)
//         {
//         }
//         field(141; "Second Language Read"; Boolean)
//         {
//         }
//         field(142; "Second Language Write"; Boolean)
//         {
//         }
//         field(143; "Second Language Speak"; Boolean)
//         {
//         }
//         field(144; "Custom Grading"; Code[20])
//         {
//             //TableRelation = Table39005744.Field2;
//         }
//         field(145; "PIN Number"; Code[20])
//         {
//         }
//         field(146; "NSSF No."; Code[20])
//         {
//         }
//         field(147; "NHIF No."; Code[20])
//         {
//         }
//         field(148; "Cause of Inactivity Code"; Code[20])
//         {
//             Caption = 'Cause of Inactivity Code';
//             TableRelation = "Cause of Inactivity";
//         }
//         field(149; "Grounds for Term. Code"; Code[20])
//         {
//             Caption = 'Grounds for Term. Code';
//             TableRelation = "Grounds for Termination";
//         }
//         field(150; "PAYROLL NO"; Code[20])
//         {
//         }
//         field(151; "Period Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             //TableRelation = "HRM-Appraisal Periods".Period;
//         }
//         field(152; "HELB No"; Text[30])
//         {
//         }
//         field(153; "Co-Operative No"; Text[30])
//         {
//         }
//         field(154; "Wedding Anniversary"; Date)
//         {
//         }
//         field(155; Grade; Code[20])
//         {
//             FieldClass = Normal;
//             // TableRelation = "HRM-Grades".Grade;
//         }
//         field(156; "Competency Area"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             // TableRelation = "HRM-Competency Areas".Code WHERE("Employee No" = FIELD("No."),
//             // Period = FIELD("Period Filter"));
//         }
//         field(157; "Division Code"; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DIVISION'));
//         }
//         field(158; "Position To Succeed"; Code[20])
//         {
//             // TableRelation = "HRM-Company Jobs"."Job ID";

//             trigger OnValidate()
//             begin
//                 /*SuccessionGap.RESET;
//                 SuccessionGap.SETRANGE(SuccessionGap."Employee No","No.");
//                 IF SuccessionGap.FIND('-') THEN
//                 SuccessionGap.DELETEALL;

//                 JobReq.RESET;
//                 JobReq.SETRANGE(JobReq."Job Id","Position To Succeed");
//                 IF JobReq.FIND('-') THEN
//                 BEGIN
//                 REPEAT
//                 IF NOT EmpQualification.GET("No.",JobReq."Qualification Code") THEN
//                 BEGIN
//                 SuccessionGap.INIT;
//                 SuccessionGap."Employee No":="No.";
//                 SuccessionGap."Job Id":=JobReq."Job Id";
//                 SuccessionGap."Qualification Type":=JobReq."Qualification Type";
//                 SuccessionGap."Qualification Code":=JobReq."Qualification Code";
//                 SuccessionGap.Qualification:=JobReq.Qualification;
//                 SuccessionGap.Priority:=JobReq.Priority;
//                 SuccessionGap.INSERT;
//                 END;
//                 UNTIL JobReq.NEXT = 0;
//                 END;
//                  */

//             end;
//         }
//         field(159; "Succesion Date"; Date)
//         {
//         }
//         field(160; "Send Alert to"; Code[20])
//         {
//             TableRelation = "HRM-Employee C"."No.";
//         }
//         field(161; Tribe; Code[20])
//         {
//             // TableRelation = Tribes."Tribe Code";
//         }
//         field(162; Religion; Code[20])
//         {
//             // TableRelation = "ACA-Religions".Religion;
//         }
//         field(163; "Job Title"; Text[50])
//         {
//         }
//         field(164; "Post Office No"; Text[30])
//         {
//         }
//         field(165; "Posting Group"; Code[30])
//         {
//             NotBlank = true;
//             // TableRelation = "HRM-Posting Groups"."Posting Group";
//         }
//         field(166; "Payroll Posting Group"; Code[20])
//         {
//             // TableRelation = "PRL-Employee Posting Group".Code;
//         }
//         field(167; "Served Notice Period"; Boolean)
//         {
//         }
//         field(168; "Exit Interview Date"; Date)
//         {
//         }
//         field(169; "Exit Interview Done by"; Code[20])
//         {
//             TableRelation = "HRM-Employee C"."No.";
//         }
//         field(170; "Allow Re-Employment In Future"; Boolean)
//         {
//         }
//         field(171; "Medical Scheme Name #2"; Text[100])
//         {
//             //TableRelation = "GEN-Medical Scheme"."Medical Scheme";

//             trigger OnValidate()
//             begin
//                 //MedicalAidBenefit.SETRANGE("Employee No.","No.");
//                 //OK := MedicalAidBenefit.FIND('+');
//                 //IF OK THEN BEGIN
//                 // REPEAT
//                 // MedicalAidBenefit."Medical Aid Name":= "Medical Aid Name";
//                 //  MedicalAidBenefit.MODIFY;
//                 // UNTIL MedicalAidBenefit.NEXT = 0;
//                 // END;
//             end;
//         }
//         field(172; "Resignation Date"; Date)
//         {
//         }
//         field(173; "Suspension Date"; Date)
//         {
//         }
//         field(174; "Demised Date"; Date)
//         {
//         }
//         field(175; "Retirement date"; Date)
//         {
//         }
//         field(176; "Date of Appointment"; Date)
//         {
//         }
//         field(177; "Section Code"; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('SECTION'));
//         }
//         field(178; Permanent; Boolean)
//         {

//             trigger OnValidate()
//             begin
//                 //Helps Filter Permanent and Casual employees
//                 // if Payroll.Get("No.") then begin
//                 //     Payroll.Permanent := Permanent;
//                 //     //Payroll.MODIFY;
//                 //end;
//             end;
//         }
//         field(179; "Library Category"; Option)
//         {
//             OptionMembers = "ADMIN STAFF","TEACHING STAFF",DIRECTORS;
//         }
//         field(180; Category; Code[20])
//         {
//         }
//         field(181; "Payroll Departments"; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

//             trigger OnValidate()
//             begin
//                 //Added to change dept on employee table and assignment matrix table
//                 //employee payroll
//                 // if Payroll.Get("No.") then begin
//                 //     Payroll."Department Code" := "Payroll Departments";
//                 //     //Payroll.MODIFY;
//                 // end;
//             end;
//         }
//         field(182; "Library Code"; Code[20])
//         {
//             // TableRelation = "ACA-Library Codes"."Lib Code";
//         }
//         field(183; "Library Borrower Type"; Option)
//         {
//             OptionCaption = 'Staff';
//             OptionMembers = Staff;
//         }
//         field(184; Names; Text[100])
//         {
//         }
//         field(185; Lecturer; Boolean)
//         {
//         }
//         field(186; "Maximun Hours"; Decimal)
//         {
//         }
//         field(187; Password; Text[50])
//         {
//         }
//         field(188; "count"; Integer)
//         {
//             CalcFormula = Count("HRM-Employee C" WHERE("No." = FIELD("No.")));
//             FieldClass = FlowField;
//         }
//         field(189; "Portal Password"; Text[30])
//         {

//             trigger OnValidate()
//             begin
//                 "Changed Password" := false;
//                 //MODIFY;
//             end;
//         }
//         field(190; "Changed Password"; Boolean)
//         {
//             Editable = false;
//         }
//         field(191; "Leave Balance"; Decimal)
//         {
//             // CalcFormula = Sum("HRM-Leave Ledger"."No. of Days" WHERE("Employee No" = FIELD("No.")));
//             // DecimalPlaces = 0 : 0;
//             // FieldClass = FlowField;
//         }
//         field(192; "Department Name"; Text[30])
//         {
//             Caption = 'Department';

//             trigger OnValidate()
//             begin
//                 //ValidateShortcutDimCode(2,"Global Dimension 2 Code");
//             end;
//         }
//         field(193; "Social Security No."; Code[30])
//         {
//         }
//         field(195; "Payroll Code"; Code[20])
//         {
//             TableRelation = "Dimension Value";
//         }
//         field(198; "Payment Mode"; Option)
//         {
//             Description = 'Bank Transfer,Cheque,Cash,SACCO';
//             OptionMembers = " ","Bank Transfer",Cheque,Cash,FOSA;
//         }
// #pragma warning disable AL0717
//         field(2003; "Total Leave Taken"; Decimal)
// #pragma warning restore AL0717
//         {
//             // CalcFormula = Sum("HRM-Leave Ledger"."No. of Days" WHERE("Transaction Type" = FILTER(Application),
//             //                                                           "Employee No" = FIELD("No."),
//             //                                                           "Entry Type" = FILTER(Application),
//             //                                                           "Leave Type" = FIELD("Leave Type")));
//             // DecimalPlaces = 2 : 2;
//             FieldClass = FlowField;
//         }
//         field(2006; "Total (Leave Days)"; Decimal)
//         {
//             DecimalPlaces = 2 : 2;
//             Editable = false;
//         }
//         field(2007; "Cash - Leave Earned"; Decimal)
//         {
//             DecimalPlaces = 2 : 2;
//         }
//         field(2008; "Reimbursed Leave Days"; Decimal)
//         {
//             DecimalPlaces = 2 : 2;

//             trigger OnValidate()
//             begin
//                 Validate("Allocated Leave Days");
//             end;
//         }
//         field(2009; "Cash per Leave Day"; Decimal)
//         {
//             DecimalPlaces = 2 : 2;
//         }
//         field(2023; "Allocated Leave Days"; Decimal)
//         {

//             trigger OnValidate()
//             begin
//                 CalcFields("Total Leave Taken");
//                 "Total (Leave Days)" := "Allocated Leave Days" + "Reimbursed Leave Days";
//                 //SUM UP LEAVE LEDGER ENTRIES
//                 "Leave Balance" := "Total (Leave Days)" - "Total Leave Taken";
//                 //TotalDaysVal := Rec."Total Leave Taken";
//             end;
//         }
//         field(2024; "Contract Start Date"; Date)
//         {
//         }
//         field(2025; "Main Bank"; Code[5])
//         {
//             //TableRelation = "PRL-Bank Structure"."Bank Code";

//             trigger OnValidate()
//             begin
//                 // PrBankStructure.SetRange(PrBankStructure."Bank Code", "Main Bank");
//                 // PrBankStructure.SetRange(PrBankStructure."Branch Code", "Branch Bank");

//                 // if PrBankStructure.Find('-') then
//                 //     "Branch Bank" := PrBankStructure."Branch Code";
//                 // "Branch Bank Name" := PrBankStructure."Branch Name";
//                 // "Main Bank Name" := PrBankStructure."Bank Name";
//             end;
//         }
//         field(2026; "Branch Bank"; Code[5])
//         {
//             // TableRelation = "PRL-Bank Structure"."Branch Code" WHERE("Bank Code" = FIELD("Main Bank"));

//             trigger OnValidate()
//             begin
//                 // PrBankStructure.SetRange(PrBankStructure."Branch Code", "Branch Bank");
//                 // if PrBankStructure.Find('-') then
//                 //     "Main Bank" := PrBankStructure."Bank Code";
//             end;
//         }
//         field(2028; "Alt. Address Start Date"; Date)
//         {
//             Caption = 'Alt. Address Start Date';
//         }
//         field(2029; "Alt. Address End Date"; Date)
//         {
//             Caption = 'Alt. Address End Date';
//         }
//         field(2034; "Bank Account Number"; Code[20])
//         {
//         }
//         field(2035; "Total Absence (Base)"; Decimal)
//         {
//             CalcFormula = Sum("Employee Absence"."Quantity (Base)" WHERE("Employee No." = FIELD("No."),
//                                                                           "Cause of Absence Code" = FIELD("Cause of Absence Filter"),
//                                                                           "From Date" = FIELD("Date Filter")));
//             Caption = 'Total Absence (Base)';
//             DecimalPlaces = 0 : 5;
//             Editable = false;
//             FieldClass = FlowField;
//         }
//         field(2036; "Cause of Absence Filter"; Code[10])
//         {
//             Caption = 'Cause of Absence Filter';
//             FieldClass = FlowFilter;
//             TableRelation = "Cause of Absence";
//         }
//         field(2037; "Leave Status"; Option)
//         {
//             OptionMembers = "On Leave"," Resumed";
//         }
//         field(2038; "Leave Type Filter"; Code[20])
//         {
//             FieldClass = FlowFilter;
//             // TableRelation = "HRM-Leave Types".Code;
//         }
//         field(2039; "Acrued Leave Days"; Decimal)
//         {
//         }
//         field(2040; "Leave Period Filter"; Code[20])
//         {
//         }
//         field(3971; "Annual Leave Account"; Decimal)
//         {
//         }
//         field(3972; "Compassionate Leave Acc."; Decimal)
//         {
//         }
//         field(3973; "Maternity Leave Acc."; Decimal)
//         {
//         }
//         field(3974; "Paternity Leave Acc."; Decimal)
//         {
//         }
//         field(3975; "Sick Leave Acc."; Decimal)
//         {
//         }
//         field(3976; "Study Leave Acc"; Decimal)
//         {
//         }
//         field(3977; OffDays; Decimal)
//         {
//         }
//         field(50000; "Citizenship Text"; Text[20])
//         {
//         }
//         field(50001; "Full Name"; Text[81])
//         {
//         }
//         field(50002; "Employee Type"; Option)
//         {
//             OptionCaption = ' ,Permanent,Casuals,Contract,Intern';
//             OptionMembers = " ",Permanent,Casuals,Contract,Intern;
//         }
//         field(50003; "Job Application No"; Code[30])
//         {
//         }
//         field(50004; "Taken Leave Days"; Decimal)
//         {
//         }
//         field(50005; "Probation Start Date"; Date)
//         {
//         }
//         field(50006; "Confirmation Date"; Date)
//         {
//         }
//         field(50008; "Days to Retirement"; Integer)
//         {
//         }
//         field(50009; "Annual Increament Date"; Date)
//         {
//         }
//         field(50010; "Date Of Present Appointment"; Date)
//         {
//         }
//         field(50011; "Employee Terms Of Service"; Option)
//         {
//             OptionCaption = 'Temporary Appointment,Designee,Consultant,Pre-Service trainee';
//             OptionMembers = "Temporary Appointment",Designee,Consultant,"Pre-Service trainee";
//         }
//         field(50012; "Station Name"; Text[5])
//         {
//             Editable = false;
//         }
//         field(50013; "Incremental Month"; Integer)
//         {
//         }
//         field(50014; "Directorate Name"; Text[20])
//         {
//             Editable = false;
//         }
//         field(50015; "County Name"; Text[30])
//         {
//             Editable = false;
//         }
//         field(50016; "Main Bank Name"; Text[50])
//         {
//         }
//         field(50017; "Branch Bank Name"; Text[50])
//         {
//             Editable = false;
//         }
//         field(60000; "Returning Officer"; Boolean)
//         {
//         }
//         field(60001; Signature; BLOB)
//         {
//             SubType = Bitmap;
//         }
//         field(60002; Registrar; Boolean)
//         {
//         }
//         field(60003; "Head of Department"; Code[10])
//         {
//             TableRelation = "HRM-Employee C"."No.";
//         }
//         field(60004; "Barcode Picture"; BLOB)
//         {
//             SubType = Bitmap;
//         }
//         field(60005; "Leave Type"; Code[30])
//         {
//             FieldClass = FlowFilter;
//             // TableRelation = "HRM-Leave Types".Code WHERE(Gender = FIELD(Gender));
//         }
//         field(60006; "Medical Scheme Join Date"; Date)
//         {
//         }
//         field(60007; "Physical Disability"; Boolean)
//         {
//         }
//         field(60008; "Salary Category"; Code[30])
//         {
//             //TableRelation = "HRM-Employee Categories".Code;
//         }
//         field(60009; "Salary Grade"; Code[20])
//         {
//             // TableRelation = "HRM-Job_Salary grade/steps"."Salary Grade code" WHERE("Employee Category" = FIELD("Salary Category"));
//         }
//         field(60010; Profession; Code[20])
//         {
//         }
//         field(60011; "On Leave"; Boolean)
//         {
//         }
//         field(60012; "Current Leave No"; Code[20])
//         {
//         }
//         field(60013; "Part Time"; Boolean)
//         {
//         }
//         field(60014; "Employee Category"; Code[20])
//         {
//             //TableRelation = "HRM-Staff Categories"."Category Code";
//         }
//         field(60015; "Campus Code"; Code[20])
//         {
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('CAMPUS'));
//         }
//         field(60016; "Is HOD"; Boolean)
//         {
//         }
//         field(60017; "Administrative HOD"; Boolean)
//         {
//         }
//         field(60023; "Is Dean"; Boolean)
//         {
//         }
//     }

//     keys
//     {
//         key(Key1; "No.")
//         {
//         }
//         key(Key2; "First Name")
//         {
//         }
//         key(Key3; "Last Name")
//         {
//         }
//         key(Key4; "ID Number")
//         {
//         }
//         key(Key5; "Cost Code")
//         {
//         }
//         key(Key6; "Date Of Join", "Date Of Leaving")
//         {
//         }
//         key(Key7; "Termination Category")
//         {
//         }
//         key(Key8; "Known As")
//         {
//         }
//         key(Key9; "User ID")
//         {
//         }
//     }

//     fieldgroups
//     {
//     }

//     trigger OnDelete()
//     begin
//         RecType := RecType::Emp;
//         // ValidateUser.validateUser(RecType);

//         // EmployeeImages.SetRange("Qualification Type", "No.");
//         // EmployeeImages.DeleteAll;

//         //EmployeeNotes.SETRANGE("Employee No.","No.");
//         //EmployeeNotes.DELETEALL;

//         // EmployeeRelative.SetRange("Employee Code", "No.");
//         // EmployeeRelative.DeleteAll;

//         //VehicleUsage.SETRANGE("Employee No.","No.");
//         //VehicleUsage.DELETEALL;

//         //CorrespondHistory.SETRANGE("Employee No.","No.");
//         //CorrespondHistory.DELETEALL;

//         // EmployeeEquity.SetRange("Employee No.", "No.");
//         // EmployeeEquity.DeleteAll;

//         // HumanResComment.SetRange("No.", "No.");
//         // HumanResComment.DeleteAll;

//         //AssignAbsence.SETRANGE("Employee No.","No.");
//         //AssignAbsence.DELETEALL;

//         //AbsenceHoliday.SETRANGE("Employee No.","No.");
//         //AbsenceHoliday.DELETEALL;

//         //EmployeePayment.SETRANGE("Entry No","No.");
//         //EmployeePayment.DELETEALL;

//         //EmployeeBankDetails.SETRANGE("Employee No.","No.");
//         //EmployeeBankDetails.DELETEALL;

//         //EmployeeMaternity.SETRANGE("No.","No.");
//         //EmployeeMaternity.DELETEALL;

//         // SAQATrainingHistory.SetRange(Code, "No.");
//         // SAQATrainingHistory.DeleteAll;

//         // EmploymentHistory.SetRange("Employee No.", "No.");
//         // EmploymentHistory.DeleteAll;

//         //MedicalHistory.SETRANGE("Employee No.","No.");
//         //MedicalHistory.DELETEALL;

//         //CareerHistory.SETRANGE("Employee No.","No.");
//         //CareerHistory.DELETEALL;

//         //Appraisal.SETRANGE("Employee No.","No.");
//         //Appraisal.DELETEALL;

//         //Disciplinary.SETRANGE("Employee No.","No.");
//         //Disciplinary.DELETEALL;

//         //ExitInterviews.SETRANGE("Employee No.","No.");
//         //ExitInterviews.DELETEALL;

//         // Grievances.SetRange("Employee No.", "No.");
//         // Grievances.DeleteAll;

//         //Appraisal.SETRANGE("Employee No.","No.");
//         //Appraisal.DELETEALL;

//         //MedicalAidBenefit.SETRANGE("Employee No.","No.");
//         //MedicalAidBenefit.DELETEALL;

//         //PensionBenefit.SETRANGE("Employee No.","No.");
//         //PensionBenefit.DELETEALL;

//         //CarBenefit.SETRANGE("Employee No.","No.");
//         //CarBenefit.DELETEALL;

//         // SAQATraining.SetRange(Code, "No.");
//         // SAQATraining.DeleteAll;

//         // LearningIntervention.SetRange("Employee Requisition No", "No.");
//         // LearningIntervention.DeleteAll;

//         // ExistingQualification.SetRange("Exit Interview No", "No.");
//         // ExistingQualification.DeleteAll;

//         // ProfessionalMembership.SetRange("Employee No", "No.");
//         // ProfessionalMembership.DeleteAll;

//         // EducationAssistance.SetRange("Application No", "No.");
//         // EducationAssistance.DeleteAll;

//         // InformalTraining.SetRange("Job Application No", "No.");
//         // InformalTraining.DeleteAll;

//         // EmployeeSkillsLines.SetRange("Member No.", "No.");
//         // EmployeeSkillsLines.DeleteAll;

//         // EmployeeSkillsPlan.SetRange("Appraisal No", "No.");
//         // EmployeeSkillsPlan.DeleteAll;
//     end;

//     trigger OnInsert()
//     begin
//         RecType := RecType::Emp;
//         // ValidateUser.validateUser(RecType);

//         if "No." = '' then begin
//             // HumanResSetup.Get;
//             //HumanResSetup.TestField("Employee Nos.");
//             //NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
//         end;

//         if "No." <> xRec."No." then begin
//             // HumanResSetup.Get;
//             //HumanResSetup.TestField("Employee Nos.");
//             //NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
//             "No. Series" := '';
//         end;


//         //CurrentPayDetails;
//     end;

//     trigger OnModify()
//     begin
//         RecType := RecType::Emp;
//         // ValidateUser.validateUser(RecType);

//         "Last Date Modified" := Today;
//         /*
//         IF Res.READPERMISSION THEN
//           EmployeeResUpdate.HumanResToRes(xRec,Rec);

//         IF SalespersonPurchaser.READPERMISSION THEN
//           EmployeeSalespersonUpdate.HumanResToSalesPerson(xRec,Rec); */
//         CurrentPayDetails;

//         if ("Department Code" <> xRec."Department Code") or
//           (Office <> xRec.Office)
//         then
//             //  UpdtResUsersetp.OnModify(Rec);
//             UpdtResUsersetp(Rec);

//     end;

//     trigger OnRename()
//     begin
//         RecType := RecType::Emp;
//         //ValidateUser.validateUser(RecType);

//         "Last Date Modified" := Today;
//     end;

//     var
//         emps: Record "HRM-Employee C";
//         // HumanResSetup: Record "HRM-Human Resources Setup.";
//         // PMEmployee: Record "HRM-Employee C";
//         // EmployeeRelative: Record "HRM-Proffessional Membership";
//         // EmployeeImages: Record "HRM-Qualifications";
//         // Relative: Record "HRM-Job Requirements";
//         // CorrespondHistory: Record "HRM-Employee Requisitions";
//         // HumanResComment: Record "HRM-Employee C";
//         // EmployeeEquity: Record "HRM-Job Occupations";
//         SalespersonPurchaser: Record "Salesperson/Purchaser";
//         //EmployeeResUpdate: Codeunit "Process Bank Acc. Rec Lines-2";
//         //EmployeePayment: Record "HRM-Qualification Levels";
//         OK: Boolean;
//         // EmployeeMaternity: Record "HRM-Pension Payments";
//         //SAQATrainingHistory: Record "HRM-Drivers";
//         // EmploymentHistory: Record "HRM-Employment History";
//         // ExitInterviews: Record "HRM-Employee SIC Numbers";
//         // Grievances: Record "HRM-Employee Course Comp.";
//         // SAQATraining: Record "HRM-Drivers";
//         // LearningIntervention: Record "HRM-Shortlisted Applicants";
//         // ExistingQualification: Record "HRM-Exit Interview Checklist";
//         // ProfessionalMembership: Record "HRM-Employee Attachments";
//         // EducationAssistance: Record "HRM-Applicant Qualifications";
//         // InformalTraining: Record "HRM-Applicant Referees";
//         // EmployeeSkillsPlan: Record "HRM-Appraisal Goal Setting L";
//         // EmployeeSkillsLines: Record "HRM-Commitee Members (KNCHR)";
//         User: Record User;
//         ERROR1: Label 'Employee Career History Starting Information already exist.';
//         MSG1: Label 'Employee Career History Starting Information successfully created.';
//         ReasonDiaglog: Dialog;
//         // Jobs: Record "HRM-Company Jobs";
//         // Payroll: Record "HRM-Employee (D)";
//         // JobReq: Record "HRM-Job Requirement";
//         // EmpQualification: Record "Employee Qualification";
//         // AssMatrix: Record "PRL-Employee Transactions";
//         // AssMatrixTemp: Record "PRL-Employee Transactions";
//         // PayPeriod: Record "PRL-Payroll Periods";
//         PayStartDate: Date;
//         PayPeriodText: Text[30];
//         // Assm: Record "PRL-Employee Transactions";
//         // CareerEvent: Page "HRM-Committees";
//         CIT: Record "Country/Region";
//         //HRSetup: Record "HRM-Setup";
//         NoSeriesMgt: Codeunit 396;
//         // HRJobs: Record "HRM-Jobs";
//         PostCodes: Record "Post Code";
//         //HRLookupValues: Record "HRM-Lookup Values";
//         CLen: DateFormula;
//         UserSetup: Record "User Setup";
//         CDate: Date;
//         Res: Record Employee;
//         EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
//         HREmp: Record "HRM-Employee C";
//         Country: Record "Country/Region";
//         Cnt: Integer;
//         // HRAE: Record "HRM-Appraisal Evaluations";
//         // HRDC: Record "HRM-Disciplinary Cases (B)";
//         // HRTRA: Record "HRM-Training Applications";
//         // HREK: Record "HRM-Employee Kin";
//         // HRJO: Record "HRM-Job Occupations";
//         //HRD: Record "HRM-Drivers";
//         HREPR: Record "HRM-Employee C";
//         //  HRAP: Record "HRM-Activity Participants";
//         // HREH: Record "HRM-Employment History";
//         // HREQ: Record "HRM-Employee Qualifications";
//         // HREEI: Record "HRM-Employee Exit Interviews";
//         // HREA: Record "HRM-Employee Attachments";
//         // HRJA: Record "HRM-Job Applications (B)";
//         // HRAQ: Record "HRM-Applicant Qualifications";
//         // HRAGSH: Record "HRM-Appraisal Goal Setting H";
//         // HRAGSL: Record "HRM-Appraisal Goal Setting L";
//         // HRCM: Record "HRM-Commitee Members (KNCHR)";
//         PostCode: Record "Post Code";
//         // PrBankStructure: Record "PRL-Bank Structure";
//         MISC: Record "Misc. Article Information";
//         //HRValueChange: Record "HRM-Value Change";
//         yDOB: Integer;
//         yTODAY: Integer;
//         noYrsToRetirement: Integer;
//         RetirementYear: Integer;
//         AppAge: Integer;
//         RetirementYear2: Text;
//         //Dates: Codeunit "HR Dates";
//         Dimn: Record "Dimension Value";
//         RetirementDate: Date;
//         dDOB: Integer;
//         mDOB: Integer;
//         DaystoRetirement: Text;
//         //ValidateUser: Codeunit "Validate User Permissions";
//         RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;

//     procedure AssistEdit(OldEmployee: Record "HRM-Employee C"): Boolean
//     begin
//         // with PMEmployee do begin
//         //     PMEmployee := Rec;
//         //     HumanResSetup.Get;
//         //     HumanResSetup.TestField("Employee Nos.");
//         //     if NoSeriesMgt.SelectSeries(HumanResSetup."Employee Nos.", OldEmployee."No. Series", "No. Series") then begin
//         //         HumanResSetup.Get;
//         //         HumanResSetup.TestField("Employee Nos.");
//         //         NoSeriesMgt.SetSeries("No.");
//         //         Rec := PMEmployee;
//         //         exit(true);
//         //      end;
//         // end;
//     end;

//     procedure FullName(): Text[100]
//     begin
//         if "Middle Name" = '' then
//             exit("Known As" + ' ' + "Last Name")
//         else
//             exit("Known As" + ' ' + "Middle Name" + ' ' + "Last Name");
//     end;

//     procedure CurrentPayDetails()
//     begin
//         if "No." = '' then begin
//             //EmployeePayment.SetFilter("Entry No", "No.");
//             // OK := EmployeePayment.Find('+');
//             if OK then begin
//                 // "Pay Period":= EmployeePayment.Description;
//                 /* "Pay Per Period":= EmployeePayment."Pay Per Period";
//                  "Contracted Hours":= EmployeePayment.Blocked;
//                  "Per Annum":= EmployeePayment."Annual Pay";
//                  "Allow Overtime":= EmployeePayment."Allow Overtime";
//                   MODIFY;   */
//             end else begin
//                 "Pay Period" := 4;
//                 "Pay Per Period" := 0;
//                 "Contracted Hours" := 0;
//                 "Per Annum" := 0;
//                 "Allow Overtime" := 2;
//                 // MODIFY;
//             end;
//         end;

//     end;

//     procedure UpdtResUsersetp(var HREmpl: Record "HRM-Employee C")
//     var
//         Res: Record Resource;
//         Usersetup: Record "User Setup";
//     begin
//         /*
//         ContMgtSetup.GET;
//         IF ContMgtSetup."Customer Integration" =
//            ContMgtSetup."Customer Integration"::"No Integration"
//         THEN
//           EXIT;
//         */
//         /*
//         Res.SETCURRENTKEY("No.");
//         Res.SETRANGE("No.",HREmpl."Resource No.");
//         IF Res.FIND('-') THEN BEGIN
//           Res."Global Dimension 1 Code" := HREmpl."Department Code";
//           Res."Global Dimension 2 Code" := HREmpl.Office;
//           Res.MODIFY;
//         END;

//         IF Usersetup.GET(HREmpl."User ID") THEN BEGIN
//           Usersetup.Department := HREmpl."Department Code";
//           Usersetup.Office := HREmpl.Office;
//           Usersetup.MODIFY;
//         END;
//         */

//     end;

//     procedure SetEmployeeHistory()
//     begin
//         /*IF NOT("No." = '') THEN
//         BEGIN
//            "HR Career History".INIT;
//            "HR Career History"."Employee No." := "No.";
//            "HR Career History".VALIDATE("Employee No.");
//            "HR Career History"."Date Of Event" := "Date Of Join";
//            "HR Career History"."Career Event" := 'Joined The Company';
//            "HR Career History".Location:= City;
//            "HR Career History".Status:= Status;
//            "HR Career History".Department := "Department Code";
//            "HR Career History".Office := Office;
//            "HR Career History".Title:= Title;
//            "HR Career History".Joined:= TRUE;
//            "HR Career History"."Job Title":= Position;
//            "HR Career History"."Full/Part Time":= "Full / Part Time";
//            "HR Career History"."Marital Status":= "Marital Status";
//            "HR Career History"."Vehicle Registration":= "Vehicle Registration Number";
//            "HR Career History"."Medical Aid Number":= "Medical Scheme No.";

//            IF ("HR Career History".INSERT) THEN
//               MESSAGE(MSG1)
//            ELSE
//               ERROR(ERROR1);
//         END;  */

//     end;

//     procedure GetPayPeriod()
//     begin

//         // PayPeriod.SetRange(PayPeriod.Closed, false);
//         // if PayPeriod.Find('-') then
//         //     PayStartDate := PayPeriod."Date Opened";
//         // PayPeriodText := PayPeriod."Period Name";
//     end;
// }

