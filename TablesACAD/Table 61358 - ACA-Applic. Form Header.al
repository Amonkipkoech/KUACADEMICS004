table 61358 "ACA-Applic. Form Header"
{
    DrillDownPageID = 68494;
    LookupPageID = 68494;

    fields
    {
        field(1; "Application No."; Code[50])
        {
            Description = 'Stores the number of the application form in the database';
        }
        field(2; Date; Date)
        {
            Description = 'Stores the date when the application was made in the database';
        }
        field(3; "Application Date"; Date)
        {
            Description = 'Stores the date when the application was issued to the student';
        }
        field(4; Surname; Text[100])
        {
            Description = 'Stores the surname of the applicant in the database';
        }
        field(5; "Other Names"; Text[100])
        {
            Description = 'Stores the other names of the applicant';
            Caption = 'Middle Name';
        }
        field(6; "Date Of Birth"; Date)
        {
            Description = 'Stores the date of birth of the applicant in the database';
        }
        field(7; Gender; Option)
        {
            Description = 'Stores the gender of the applicant in the database';
            OptionMembers = " ",Male,Female;
        }
        field(8; "Marital Status"; Option)
        {
            Description = 'Stores the marital status of the applicant in the database';
            OptionMembers = " ",Single,Married;
        }
        field(9; Nationality; Code[50])
        {
            Description = 'Stores the nationality of the applicant in the database';
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Nationality));
        }
        field(10; "Country of Origin"; Code[50])
        {
            Caption = 'Nationality';
            Description = 'Stores the country of origin in the database';
            TableRelation = "Country/Region".Code;
        }
        field(11; "Address for Correspondence1"; Text[50])
        {
            Caption = 'Postal Address';
            Description = 'Stores the first line of the correspondence address';
        }
        field(12; "Address for Correspondence2"; Text[50])
        {
            Caption = 'Postal Code';
            Description = 'Stores the second line of the correspondence address';
        }
        field(13; "Address for Correspondence3"; Text[50])
        {
            Caption = 'Town/Street';
            Description = 'Stores the third line of correspondence address in the database';
        }
        field(14; "Telephone No. 1"; Code[30])
        {
            Description = 'Stores the first telephone number of the applicant';
        }
        field(15; "Telephone No. 2"; Code[50])
        {
            Description = 'Stores the second telephone number of the applicant';
        }
        field(16; "First Degree Choice"; Code[50])
        {
            Description = 'Stores the first degree choice for the applicant';
            TableRelation = "ACA-Programme".code;
            //.Code WHERE(Code = FIELD("First Degree Choice"), Category = field("First Choice Category"));
            trigger OnValidate()
            var
                progCode: Record "ACA-Programme";
            begin
                progCode.Reset();
                progCode.SetRange(Code, "First Degree Choice");
                if progCode.Find('-') then begin
                    progCode.TestField("Department Code");
                    progCode.TestField(Faculty);
                    "Programme Department" := progCode."Department Code";
                    "Programme School" := progCode.Faculty;
                    programName := progCode.Description;
                    "Faculty Name" := progCode."Faculty Name";
                    Rec.Modify();


                end;
            end;

        }
        field(17; School1; Code[100])
        {
            Description = 'Stores the first faculty choice for the applicant';
            TableRelation = "Dimension Value".Code WHERE(Name = FIELD(School1));
        }
        field(18; "Second Degree Choice"; Code[50])
        {
            Description = 'Stores the second degree choice for the applicant';
            TableRelation = "ACA-Programme".Code;
        }
        field(19; "School 2"; Code[50])
        {
            Description = 'Stores the second faculty for the applicant';
        }
        field(20; "Date of Receipt"; Date)
        {
            Description = 'Stores the date of receipt of the application form from the student';
        }
        field(21; "User ID"; Code[50])
        {
            Description = 'Stores the code of the user who received the application from the applicant';
        }
        field(22; County; Code[20])
        {
            Description = 'Stores the district or the applicant in the database';
            TableRelation = County;
        }
        field(23; "Former School Code"; Code[100])
        {
            Description = 'Stores the code of the former school that the student attended';
            //TableRelation = "ACA-Applic. Setup Fmr School".Code;
        }
        field(24; "Date of Admission"; Date)
        {
            Description = 'Stores the date of admission to the former school';
        }
        field(25; "Date of Completion"; Date)
        {
            Description = 'Stores the date of completion in the former school';
        }
        field(26; "Year of Examination"; Text[20])
        {
            Description = 'Stores the year of examination in the database';
        }
        field(27; "Examination Body"; Text[30])
        {
            Description = 'Stores the examination body';
        }
        field(28; "Mean Grade Acquired"; Code[50])
        {
            Description = 'Stores the mean grade acquired';
        }
        field(29; "Points Acquired"; Integer)
        {
            Description = 'Stores the grade acquired';
        }
        field(30; "Principal Passes"; Integer)
        {
            Description = 'Stores the principal passes';
        }
        field(31; "Subsidiary Passes"; Integer)
        {
            Description = 'Stores the subsidiary passes';
        }
        field(32; Examination; Option)
        {
            Description = 'Stores the examination done';
            OptionMembers = KCSE,KCE,EACE,KACE,EAAC,Others;
        }
        field(33; "Application Form Receipt No."; Code[50])
        {
            Description = 'Stores the receipt number used to pay for the application number';
        }
        field(34; "Index Number"; Code[30])
        {
            Caption = 'High Sch. Index Number';
            Description = 'Stores the index number of the student in the database';
        }
        field(35; "No. Series"; Code[50])
        {
            Description = 'Stores the reference to the number series in the database';
            TableRelation = "No. Series".Code;
        }
        field(36; "HOD User ID"; Code[50])
        {
            Description = 'Stores the reference to the head of department';
        }
        field(37; "HOD Date"; Date)
        {
            Description = 'Stores the date when the HOD Makes the recommendation';
        }
        field(38; "HOD Time"; Time)
        {
            Description = 'Stores the time when the HOD makes the recommendation';
        }
        field(39; "HOD Recommendations"; Text[200])
        {
            Description = 'Stores the recomendation of the head of department';
        }
        field(40; "Dean User ID"; Code[50])
        {
            Description = 'Stores the reference to the head of department';
        }
        field(41; "Dean Date"; Date)
        {
            Description = 'Stores the date when the HOD Makes the recommendation';
        }
        field(42; "Dean Time"; Time)
        {
            Description = 'Stores the time when the HOD makes the recommendation';
        }
        field(43; "Dean Recommendations"; Text[200])
        {
            Description = 'Stores the recomendation of the head of department';
        }
        field(423; "Age2"; Text[200])
        {
            Description = 'Stores the recomendation of the head of department';
        }
        field(44; Status; Option)
        {
            Description = 'Stores the status of the application in the database';
            //OptionCaption = 'Open,Pending Approval,Department Rejected,Department Approved,Dean,Dean Rejected,Dean Approved,Academic Division,Admission Board,Approved,Admission Board Rejected,Provisional Admission,Defferred,Admission Letter';
            OptionMembers = Open,"Pending Approval","Department Rejected","Department Approved",Dean,"Dean Rejected","Dean Approved","Academic Division","Admission Board",Approved,"Admission Board Rejected","Provisional Admission",Defferred,"Admission Letter",Admitted;

            trigger OnValidate()
            begin

                IF Status = Status::Approved THEN BEGIN
                    /*Check if the receipt slip no and the deposit dates are entered*/
                    IF ("Receipt Slip No." = '') OR ("Date Of Receipt Slip" = 0D) THEN BEGIN
                        //ERROR('Please Enter the Bank Slip No. and the Deposit date first.');
                    END;
                    GeneralSetup.GET;
                    //IF "Global Dimension 1 Code"='' THEN ERROR('Please Specify the Campus Code first')
                    //ELSE Campo:="Global Dimension 1 Code";
                    //IF "Intake Code"='' THEN ERROR('Please Specify the INTAKE first.')
                    IF "Intake Code" <> '' THEN intake := "Intake Code";
                    VALIDATE("Settlement Type");
                    IF "Settlement Type" = '' THEN
                        ERROR('Specify the Mode of Study First')
                    ELSE
                        modes := "Settlement Type";
                    IF "First Degree Choice" = '' THEN ERROR('Specify the Programme first');

                    /*
                    {This function transfers the details of the applicant to the admissions table}
                    PrintAdmission:=FALSE;
                    AdminSetup.RESET;
                    AdminSetup.SETRANGE(AdminSetup.Degree,"First Degree Choice");
                    IF AdminSetup.FIND('-') THEN
                      BEGIN
                        NewAdminCode:=NoSeriesMgt.GetNextNo(AdminSetup."No. Series",0D,TRUE);
                      IF "First Choice Semester" = 'SEM 1' THEN sem := '1'
                      ELSE IF  "First Choice Semester" = 'SEM 2' THEN sem := '2'
                      ELSE IF  "First Choice Semester" = 'SEM 3' THEN sem := '3';
                      //NewAdminCode:=sem+NewAdminCode;
                      CLEAR(SetlementType);
                      IF (("Settlement Type"='PSSP') OR ("Settlement Type"='PSSP')) THEN SetlementType:='PSSP'
                      ELSE SetlementType:='KUCCPS';
                      IF SetlementType='KUCCPS' THEN
                        NewAdminCode:=AdminSetup."Programme Prefix"+ '-' +NewAdminCode+ '/' + AdminSetup.Year
                        ELSE
                        NewAdminCode:=AdminSetup."Programme Prefix"+ '-' +NewAdminCode+ '/' + AdminSetup.Year;
                      END
                    ELSE
                      BEGIN
                        ERROR('The Admission Number Setup For Programme ' +FORMAT("Admitted Degree") + ' has not been Setup.');
                      END;

                    {Get the record and transfer the details to the admissions database}

                        {Transfer the details into the admission database table}
                          Admissions.INIT;
                            Admissions."Admission No.":=NewAdminCode;
                           Admissions.VALIDATE(Admissions."Admission No.");
                            Admissions.Date:=TODAY;
                            Admissions."Application No.":="Application No.";
                            Admissions."Admission Type":='DIRECT';
                            Admissions."Academic Year":="Academic Year";
                            Admissions.Surname:=Surname;
                            Admissions."Admission Comments":="Admission Comments";
                            Admissions."Other Names":="Other Names";
                            Admissions.Status:=Admissions.Status::New;
                            Admissions."Degree Admitted To":="First Degree Choice";
                            Admissions.Salutation:=Salutation;
                            Admissions.VALIDATE(Admissions."Degree Admitted To");
                            Admissions."Date Of Birth":="Date Of Birth";
                            Admissions.Gender:=Gender;
                            Admissions."Marital Status":="Marital Status";
                            Admissions.Nationality:=Rec.Nationality;
                            Admissions."Correspondence Address 1":="Address for Correspondence1";
                            Admissions."Correspondence Address 2":="Address for Correspondence2";
                            Admissions."Correspondence Address 3":="Address for Correspondence3";
                            Admissions."Telephone No. 1":="Telephone No. 1";
                            Admissions."Telephone No. 2":="Telephone No. 2";
                            Admissions."Former School Code":="Former School Code";
                            Admissions."Settlement Type":="Settlement Type";
                            Admissions."Index Number":="Index Number";
                            Admissions."ID Number":="ID Number";
                            IF  "Admitted To Stage"<>'' THEN
                            Admissions."Stage Admitted To":="Admitted To Stage" ELSE
                            IF Rec."First Choice Stage"<>'' THEN
                            Admissions."Stage Admitted To":="First Choice Stage";
                            Admissions."Semester Admitted To":= "Admitted Semester";
                            Admissions."Settlement Type":=modes;
                            Admissions."Global Dimension 1 Code":="Global Dimension 1 Code";//Campo;
                            Admissions."Intake Code":="Intake Code";
                            Admissions.Campus:=Campus;
                            prog.RESET;
                            prog.SETRANGE(prog.Code,"First Degree Choice");
                            IF prog.FIND('-') THEN BEGIN
                           // Admissions.Department:=prog.Department;
                            END;

                          //  IF Rec."Intake Code"='' THEN ERROR('Please Specify the Intake before Admiting the Student.');
                            Admissions."Stage Admitted To":=GeneralSetup."Default Year";
                            Admissions."Semester Admitted To":=GeneralSetup."Default Semester";
                            Admissions."Intake Code":=GeneralSetup."Default Intake";
                           // Admissions."Stage Admitted To":=
                          Admissions.INSERT();


                    TransferToAdmission2(PrintAdmission);
                    Rec.MODIFY;*/
                    MESSAGE('The Application has been sent to the ''Issued Admissions'' Level for Approval.');

                END;

            end;
        }
        field(45; Select; Boolean)
        {
            Description = 'Enables the user to select a record to process';
        }
        field(46; "Batch No."; Code[50])
        {
            Description = 'Stores the batch number of the selected record';
        }
        field(47; "Batch Date"; Date)
        {
        }
        field(48; "Batch Time"; Time)
        {
        }
        field(49; "Admission Board Recommendation"; Text[100])
        {
        }
        field(50; "Admission Board Date"; Date)
        {
        }
        field(51; "Admission Board Time"; Time)
        {
        }
        field(52; "Admitted Degree"; Code[50])
        {
            TableRelation = "ACA-Programme".Description;
        }
        field(53; "Admitted Department"; Code[50])
        {
        }
        field(54; "Deferred Until"; Date)
        {
        }
        field(55; "Date Of Meeting"; Date)
        {
        }
        field(56; "Date Of Receipt Slip"; Date)
        {
        }
        field(57; "Receipt Slip No."; Code[50])
        {
            trigger OnValidate()
            var
                receipt: Record "FIN-Receipts Header";
            begin

                receipt.Reset();
                receipt.SetRange("No.", "Receipt Slip No.");
                if not receipt.Find('-') then
                    error('Check the Receipt No. is invalid');


            end;
        }
        field(58; "Academic Year"; Code[50])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(59; "Admission No"; Code[50])
        {
        }
        field(60; "Admitted To Stage"; Code[20])
        {
            Description = 'Stores the stage  that the student is admitted to';
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("Admitted Degree"));
        }
        field(61; "Admitted Semester"; Code[20])
        {
            Description = 'Stores the semester that the student is admitted to';
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Admitted Degree"));
        }
        field(62; "First Choice Stage"; Code[50])
        {
            Description = 'Stores the first stage choice for the student';
            TableRelation = "ACA-Programme Stages".Code WHERE("Programme Code" = FIELD("First Degree Choice"));
        }
        field(63; "First Choice Semester"; Code[50])
        {
            Description = 'Stores the semester in the database';
            TableRelation = "ACA-Intake";
            // trigger OnValidate()
            // var
            //     incode: record "ACA-Intake";
            // begin
            //     incode.Reset();
            //     incode.SetRange(code, "Intake Code");
            //     if incode.Find('-') then begin
            //         "Date Letter of admission" := incode."Reporting Date";
            //     end;
            // end;
        }
        field(64; "Second Choice Stage"; Code[50])
        {
            Description = 'Stores the second choice stage';
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("First Degree Choice"));
        }
        field(65; "Second Choice Semester"; Code[20])
        {
            Description = 'Stores the second semester stage';
            TableRelation = "ACA-Programme Semesters".Semester WHERE("Programme Code" = FIELD("Second Degree Choice"));
        }
        field(66; "Intake Code"; Code[20])
        {
            Description = 'Stores the code of the intake in the database';
            TableRelation = "ACA-Intake".Code;
            trigger OnValidate()
            var
                incode: record "ACA-Intake";
            begin
                incode.Reset();
                incode.SetRange(code, "Intake Code");
                if incode.Find('-') then begin
                    "Date Letter of admission" := incode."Reporting Date";
                end;
            end;
        }
        field(67; "Settlement Type"; Code[50])
        {
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(68; "ID Number"; Code[20])
        {
            Description = 'Stores the id number of the applicant in the database';

            trigger OnValidate()
            begin
                /*
                Apps.RESET;
                Apps.SETRANGE(Apps."ID Number","ID Number");
                IF Apps.COUNT >1 THEN
                  BEGIN
                    IF CONFIRM('The ID Number has been used in a prior Application. Continue?',TRUE)=TRUE THEN BEGIN EXIT END;
                    ERROR('Application Process Cancelled.');
                  END;
                 */

            end;
        }
        field(69; "Date Sent for Approval"; Date)
        {
        }
        field(70; "Issued Date"; Date)
        {
        }
        field(71; "Post Graduate"; Boolean)
        {
        }
        field(72; Email; Text[100])
        {
        }
        field(73; Campus; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(74; "Admissable Status"; Code[20])
        {
            TableRelation = "ACA-Admissable Status".Code;
        }
        field(75; "Mode of Study"; Code[50])
        {
            Caption = 'Program Mode of Study';
            TableRelation = "ACA-Student Types".Code;
        }
        field(76; "Enquiry No"; Code[20])
        {
            TableRelation = "ACA-Enquiry Header"."Enquiry No." WHERE(Status = FILTER(New));

            trigger OnValidate()
            begin
                IF EnqH.GET("Enquiry No") THEN BEGIN
                    Apps.RESET;
                    Apps.SETRANGE(Apps."Enquiry No", "Enquiry No");
                    Apps.SETFILTER(Apps."Application No.", '<>%1', "Application No.");
                    IF Apps.FIND('-') THEN BEGIN
                        ERROR('The Equiry number has already been used but its still pending spproval.');
                    END;

                    Surname := EnqH.Surname;
                    "Other Names" := EnqH."Other Names";
                    Gender := (EnqH.Gender - 1);
                    "Address for Correspondence1" := EnqH."Correspondence Address";
                    "Telephone No. 1" := EnqH."Mobile Number";
                    "First Degree Choice" := EnqH.Programmes;
                    "First Choice Stage" := EnqH."Programme Stage";
                    "First Choice Semester" := EnqH.Semester;
                    "ID Number" := EnqH."Passport/National ID Number";
                    "Intake Code" := EnqH.Intake;
                    Campus := EnqH."Campus Code";
                    "Mode of Study" := EnqH."Mode of Study";
                    "Date Of Birth" := EnqH."Date of Birth";
                    "Issued Date" := TODAY;
                    "Programme Level" := GetDegree(EnqH.Programmes);
                    "Academic Year" := FORMAT(GetCurrYear());
                    "Knew College Thru" := EnqH."How You knew about us";

                    //EnqH."Application  No.":="Application No.";
                    //EnqH."Converted To Application":=TRUE;
                    //EnqH.Closed:=TRUE;
                    //EnqH.MODIFY;
                END ELSE
                    ERROR('Enquiry not found!');
            end;
        }

        field(77; "Submission Status"; option)
        {
            OptionMembers = " ","FAB Submission","UABC List","UAB Ratified","FAB Rejected","Dean Rejected";
        }
        field(85; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            TableRelation = "ACA-Stage Charges";
        }
        field(86; "Admit/NotAdmit"; Code[20])
        {
        }
        field(87; "Documents Verified"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(88; "Documents Verification Remarks"; Text[200])
        {
        }
        field(89; "Medical Verified"; Boolean)
        {
        }
        field(90; "First Choice Qualify"; Boolean)
        {
        }
        field(91; "Second Choice Qualify"; Boolean)
        {
        }
        field(92; "First Name"; Text[100])
        {
            Description = 'Stores the surname of the applicant in the database';
        }
        field(93; "Passport Number"; code[30])
        {
            Description = 'Stores Passport No of the Applicant';
        }
        field(94; "Birth Cert No"; code[30])
        {
            Description = 'Stores Birth Certificate Number of applicant';
        }
        field(95; Ethnicity; Code[20])
        {
            TableRelation = "HRM-Ethnicity";

        }
        field(96; Disability; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(97; "Nature of Disability"; Option)
        {

            OptionMembers = None,"Sensory Impairement","Mental Impairement","Visiual Impairement","Hearing Impairement","Learning Impairement","Physical Impairement",Other;

        }
        field(98; "Former Student"; Boolean)
        {

        }
        field(99; "Former KTRH Reg Number"; code[30])
        {

        }

        field(100; Religion; Code[20])
        {
            TableRelation = "ACA-Religions".Religion;
        }
        field(101; Congregation; Option)
        {
            OptionMembers = " ",Lay,Brothers,Sisters,"Diocesan-Priest","Religious-Priest",Seminarian,Novice,Deacon;
        }
        field(102; Diocese; Text[100])
        {

        }
        field(103; "Order/Instutute"; Text[100])
        {

        }
        field(104; "Protestant Congregation"; Option)
        {
            OptionMembers = " ",ACK,AIC,PCEA,SDA,Other;
        }
        field(105; "College/UNV attended"; Text[100])
        {

        }
        field(106; "College/Unv attend start date"; date)
        {

        }
        field(107; "College/Unv attend final date"; date)
        {

        }
        field(108; "Degree/Cert/Dip earned"; Text[150])
        {

        }
        field(110; "High Sch Leav Cert"; Text[100])
        {

        }
        field(111; "Nationality Code"; Code[10])
        {
            TableRelation = "Country/Region".Code;
            trigger OnValidate()
            var
                country: Record "Country/Region";
            begin
                if country.Get("Nationality Code") then
                    Nationality := country.Name;
            end;
        }
        //added later but next of kin table is already defined////////////////////////////////////
        field(112; "Next of kin Name"; text[100])
        {

        }
        field(113; "Next of kin Mobile"; text[100])
        {

        }
        field(114; "Next of Kin R/Ship"; code[20])
        {
            TableRelation = Relative.Code;
        }
        field(115; "Next Of Kin Email"; text[100])
        {

        }
        ////////////////////////////////////////////feee payer infromation is also available in another page 
        field(116; "Fee payer Names"; text[100])
        {

        }
        field(117; "Fee payer mobile"; text[20])
        {

        }
        field(118; "Fee payer Email"; text[50])
        {

        }
        field(119; "Fee payer R/Ship"; code[20])
        {
            TableRelation = Relative.Code;
        }

        ////////////////////////////////////////END OF FEE PAYER DETAILS---------------------------------------
        field(120; "Previous Education Level"; Option)
        {
            OptionMembers = HighSchool,Certificate,Diploma,Bachelors,Masters,Doctorate;
        }

        field(122; "Programme Department"; code[30])
        {

        }
        field(123; "Programme School"; code[30])
        {

        }
        field(124; formerSchool; code[200])
        {

        }
        field(125; programName; Text[100])
        {

        }
        field(126; "Faculty Name"; Text[100])
        {

        }
        field(50000; "Rejection Reason"; Text[250])
        {
        }
        field(50001; "Programme Level"; Option)
        {
            OptionMembers = " ",Certificate,Diploma;
        }
        field(50002; "Knew Through (Other)"; Text[250])
        {

            trigger OnValidate()
            begin
                IF "Knew Through (Other)" <> '' THEN
                    "Knew College Thru" := 'OTHER'
            end;
        }
        field(50003; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('CAMPUS'));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(50004; Salutation; Code[10])
        {
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Titles));
        }
        field(50005; "OLevel Cert Image"; BLOB)
        {
        }
        field(50006; "ALevel Cert Image"; BLOB)
        {
        }
        field(50007; Password; Text[30])
        {
        }
        field(50008; "Admission Comments"; Text[100])
        {
        }
        field(50009; "Knew College Thru"; Text[30])
        {
            TableRelation = "ACA-Marketing Strategies".Code;
        }
        field(50010; "First Choice Category"; Option)
        {
            CalcFormula = Lookup("ACA-Programme".Category WHERE(Code = FIELD("First Degree Choice")));
            FieldClass = FlowField;
            OptionMembers = " ",Certificate,Diploma,Bachelor,Postgraduate,"Postgraduate Diploma",Masters,Doctorate,"Course List",Undergraduate,Professional;
        }
        field(50011; District; Code[30])
        {
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Districts));
        }
        field(50012; Denomination; Code[20])
        {
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Denominations));
        }
        field(50013; Title; Code[10])
        {
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Titles));
        }
        field(50014; "Emergency Name"; Text[30])
        {
        }
        field(50015; "Emergency Email"; Text[50])
        {
        }
        field(50016; "Emergency Telephone"; Code[10])
        {
        }
        field(50017; "Emergency Fax"; Code[10])
        {
        }
        field(50018; "Emergency Relationship"; Code[20])
        {
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Relationships));
        }
        field(50019; "Got Health Insurance"; Boolean)
        {
        }
        field(50020; "Name of Insurer"; Code[20])
        {
            //TableRelation = Table50076.Field1;
        }
        field(50021; "Language 1"; Code[10])
        {
            TableRelation = Language.Code;
        }
        field(50022; "Language 2"; Code[10])
        {
            TableRelation = Language.Code;
        }
        field(50023; "Payments Verified"; Boolean)
        {
        }
        field(50024; "Old Status"; Code[20])
        {
        }
        field(50025; "Temp Prog"; Code[20])
        {
        }
        field(50026; OnlineSeq; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Mode Of Payment"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50028; "Admissible"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50029; "KNQA Equistion"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Shortlisted By(Staff ID)"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            var
                empc: Record "HRM-Employee (D)";
            begin
                empc.Reset();
                empc.SetRange("No.", "Shortlisted By(Staff ID)");
                if empc.Find('-') then begin
                    "Shortlisted By(Staff Name)" := empc."First Name" + ' ' + empc."Middle Name" + ' ' + empc."Last Name";
                end;
            end;

        }
        field(50031; "Shortlisted By(Staff Name)"; Text[50])
        {
            DataClassification = ToBeClassified;

        }
        field(50032; "Documents Verified By"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            var
                names: Record "HRM-Employee (D)";
            begin
                if names.Get("Documents Verified By") then
                    "Document Verified Name" := names."First Name" + names."Middle Name" + names."Last Name";
            end;
        }
        field(50066; "Document Verified Name"; Text[100])
        {

        }
        field(50033; "FAB Approved"; Boolean)
        {
            Editable = false;
        }
        field(50034; "FAB Date of Approval"; Date)
        {
            Editable = false;
        }
        field(50035; "FAB Staff ID"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            var
                hrmep: Record "HRM-Employee (D)";
            begin
                if hrmep.get("FAB Staff ID") then
                    "FAB Chair Names" := hrmep."Last Name" + ' ' + hrmep."Middle Name" + ' ' + hrmep."First Name";
            end;
        }
        field(50036; "FAB Chair Names"; Text[100])
        {
            Editable = false;
        }
        field(50037; "UAB Approved"; Boolean)
        {
            Editable = false;
        }
        field(50038; "UAB Approval Date"; Date)
        {
            Editable = false;
        }
        field(50039; "UAB Staff ID"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            var
                hrmep: Record "HRM-Employee (D)";
            begin
                if hrmep.get("FAB Staff ID") then
                    "UAB  Staff Name" := hrmep."Last Name" + ' ' + hrmep."Middle Name" + ' ' + hrmep."First Name";
            end;
        }

        field(50040; "UAB  Staff Name"; Text[50])
        {
            Editable = false;

        }

        field(50041; "Program Duration"; Integer)
        {

        }
        field(50042; "Date Letter of admission"; Date)
        {

        }
        field(50043; "Registrar Issu of Adm.letter"; Boolean)
        {
            Caption = 'Registrar Issue of admission letter';
        }
        field(50044; "Registrar Issue ADM"; Text[100])
        {
            TableRelation = "HRM-Employee (D)";
            Caption = 'Registrar Issue of admission letter';
        }

        field(50045; "KCSE Cert Attached"; Boolean)
        {
            Caption = 'High School Cert Attached';
        }
        field(50046; "High Sch. Rslt Slip Attached"; Boolean)
        {
            Caption = 'High School Result slip attched';
        }
        field(50047; "Undergrad Cert attached"; Boolean)
        {
            Caption = 'Undergrad Cert and  and transcript attached';
        }
        field(50048; "Master Transcript attached"; Boolean)
        {
            Caption = 'Undergrad Cert and  and transcript attached';
        }

        field(50049; "Transfer Case"; Boolean)
        {
            Caption = 'Transfer Case';
        }
        field(50050; "Transfer Letter Attached"; Boolean)
        {
            Caption = 'Transfer Letter Attached';
        }
        field(50051; "High Sch. Cert attched"; Boolean)
        {
            Caption = 'High School Certificate attached';
        }
        field(50052; "ID/Birth Cert attached"; Boolean)
        {
            Caption = 'ID/Birth Cert attched';
        }
        field(50053; "Medical Documents Verified"; Boolean)
        {
            Caption = 'Medical Documents Verified';
        }
        field(50054; "Declaration Form Attached"; Boolean)
        {
            Caption = 'Declaration Form Attached';
        }
        field(5005; "Admission Status"; Boolean)
        {
            Caption = 'Admission Status';
        }
        field(50055; "Shortlisted"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(50056; "Admission Qualification Summ"; Text[250])
        {

            Caption = 'Admission Qualification Summary';

        }
        field(50057; "Qualification Summary"; Text[250])
        {

            Caption = 'Qualification Summary';

        }
        field(50058; "Reg Issu of Adm.letter Name"; Text[50])
        {
            Caption = 'Registrar Issue of admission letter Name';
        }
        field(50059; "High Sch. Leaving cert."; Code[50])
        {
            Caption = 'Registrar Issue of admission letter Name';
        }
        field(50060; "High Sch. Leaving cert. No."; Code[50])
        {
        }
        field(50061; "Medical report attached"; Option)
        {
            OptionMembers = " ",Yes,No;
        }
        field(50062; "Adm Status"; Option)
        {
            Caption = 'Admission Status';
            OptionMembers = " ",Transferred,Withdrawn,Deferred;
        }

        field(50064; "Registra No."; code[30])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            var
                hrmep: record "HRM-Employee (D)";
            begin
                hrmep.Reset();
                hrmep.SetRange("No.", "Registra No.");
                if hrmep.Find('-') then begin
                    "Issue Registrar Name" := hrmep."First Name" + ' ' + hrmep."Middle Name" + ' ' + hrmep."Last Name";
                end;

            end;
        }
        field(50065; "Issue Registrar Name"; text[100])
        {


        }
        field(50067; "ADM Letter ATT"; boolean)
        {

        }
        field(50068; "Finance Cleared"; boolean)
        {

        }
        field(50069; "Fee payable"; text[150])
        {

        }
        field(50070; "Reporting date"; Date)
        {

        }
        field(50071; "Process Application"; Boolean)
        {
            // trigger OnValidate()
            // begin
            //     "User ID" := UserId;
            //     Modify();
            // end;
        }
        field(50072; returned; Boolean)
        {

        }
        field(50073; "High School Certificate"; text[200])
        {

        }
        field(50074; "High School Result slip"; text[200])
        {

        }
        field(50075; "Under Graduate Certificate"; text[200])
        {

        }
        field(50076; "Masters Transcript"; text[200])
        {

        }
        field(50077; "Reg Staff id"; code[20])
        {

        }
        field(50078; "Fin Staff id"; code[20])
        {

        }
        field(50079; "Initiated Contact"; Boolean)
        {

        }
        field(50080; RevrtUserID; Code[20])
        {

        }
        field(50081; "Appeal Reason"; text[200])
        {

        }
        field(50082; NationalityName; text[150])
        {
            CalcFormula = lookup("ACA-Academics Central Setups".Description where("Title Code" = field(Nationality)));
            FieldClass = FlowField;
        }
        field(50083; "SRO UserID"; code[20])
        {

        }
        field(50084; "Application Type"; Option)
        {
            OptionMembers = Full,Provisional;
        }
        field(50085; "Provisional Admision Reason"; Option)
        {
            OptionMembers = " ","Pending submission of your certificate/diploma certificate and transcripts","Pending submission of your Bachelors certificate and transcripts","Pending submission of recognition of your Bachelors/Masters Certificate from CUE","Pending submission of your equated results from KNQA","Pending submission of your KCSE KNEC result slip";
        }
        field(50086; "DAB Staff ID"; Code[20])
        {
            TableRelation = "HRM-Employee (D)"."No.";
            trigger OnValidate()
            var
                hrmep: Record "HRM-Employee (D)";
            begin
                if hrmep.get("FAB Staff ID") then
                    "FAB Chair Names" := hrmep."Last Name" + ' ' + hrmep."Middle Name" + ' ' + hrmep."First Name";
            end;
        }
        field(50087; "DAB Chair Names"; Text[100])
        {
            Editable = false;
        }
        field(50088; "DAB Date of Approval"; Date)
        {
            Editable = false;
        }



    }









    keys
    {
        key(Key1; "Application No.")
        {
        }
        key(Key2; School1)
        {
        }
        key(Key3; "First Degree Choice")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        IF "Application No." = '' THEN BEGIN
            AppSetup.GET;
            AppSetup.TESTFIELD("Application Form Nos.");
            NoSeriesMgt.InitSeries(AppSetup."Application Form Nos.", xRec."No. Series", 0D, "Application No.", "No. Series");
        END;
        GeneralSetup.GET;

        Date := TODAY;
        "Application Date" := TODAY;
        "Settlement Type" := 'GSS';
        "User ID" := USERID;
        "First Choice Stage" := GeneralSetup."Default Year";
        "First Choice Semester" := GeneralSetup."Default Semester";
        "Intake Code" := GeneralSetup."Default Intake";
    end;

    var
        SetlementType: Code[10];
        AppSetup: Record 61367;
        NoSeriesMgt: Codeunit 396;
        Apps: Record 61358;
        EnqH: Record 61348;
        modes: Code[10];
        DegreeName1: Text[100];
        DegreeName2: Text[100];
        FacultyName1: Text[100];
        FacultyName2: Text[100];
        NationalityName: Text[100];
        CountryOfOriginName: Text[100];
        //Age: Text[100];
        FormerSchoolName: Text[100];
        CustEntry: Record 21;
        recProgramme: Record 61511;
        Applications: Record 61358;
        AdminSetup: Record 61371;
        NewAdminCode: Code[20];
        Admissions: Record 61372;
        ApplicationSubject: Record 61362;
        AdmissionSubject: Record 61375;
        LineNo: Integer;
        PrintAdmission: Boolean;
        MedicalCondition: Record 61379;
        Immunization: Record 61380;
        AdmissionMedical: Record 61376;
        AdmissionFamily: Record 61377;
        sem: Text[2];
        Campo: Code[10];
        intake: Code[10];
        prog: Record 61511;
        GeneralSetup: Record 61534;

    procedure GetCountry(var CountryCode: Code[100]) CountryName: Text[100]
    var
        Country: Record 9;
    begin
        /*This function gets the country name from the database and returns the resultant string value*/
        // Country.RESET;
        // IF Country.GET(CountryCode) THEN BEGIN
        //     CountryName := Country.Name;
        // END
        // ELSE BEGIN
        //     CountryName := '';
        // END;

    end;

    procedure GetDegree(var DegreeCode: Code[20]) ProgLevel: Integer
    var
        Programme: Record 61511;
    begin
        /*This function gets the programme Level and returns the resultant string*/
        Programme.RESET;
        IF Programme.GET(DegreeCode) THEN BEGIN
            ProgLevel := Programme.Category;
        END
        ELSE BEGIN
            ProgLevel := 0;
        END;

    end;

    procedure GetFaculty(var DegreeCode: Code[20]) FacultyName: Text[100]
    var
        Programme: Record "ACA-Programme";
        DimVal: Record "Dimension Value";
    begin
        /*The function gets and returns the faculty name to the calling client*/
        FacultyName := '';
        Programme.RESET;
        IF Programme.GET(DegreeCode) THEN BEGIN
            DimVal.RESET;
            DimVal.SETRANGE(DimVal."Dimension Code", 'FACULTY');
            DimVal.SETRANGE(DimVal.Code, Programme.Faculty);
            IF DimVal.FIND('-') THEN BEGIN
                FacultyName := DimVal.Name;
            END;
        END;

    end;

    procedure GetAge(var StartDate: Date) AgeText: Text[100]
    var
        HrDates: Codeunit "ACA-Dates";
    begin
        /*This function gets the age of the applicant and returns the resultant age to the calling client*/
        AgeText := '';
        IF StartDate = 0D THEN BEGIN StartDate := TODAY END;
        AgeText := HrDates.DetermineAge(StartDate, TODAY);

    end;

    procedure GetFormerSchool(var FormerSchoolCode: Code[50]) FormerSchoolName: Text[50]
    var
        FormerSchool: Record 61366;
    begin
        /*This function gets the description of the former school and returns the result to the calling client*/
        FormerSchool.RESET;
        FormerSchoolName := '';
        IF FormerSchool.GET(FormerSchoolCode) THEN BEGIN
            FormerSchoolName := FormerSchool.Description;
        END;

    end;

    procedure TransferToAdmission2(var Print: Boolean)
    begin
        /*This function transfers the fields in the application to the fields in the admissions table*/
        /*Get the new admission code for the selected application*/

        Rec."Admission No" := Admissions."Admission No.";
        /*Get the subject details and transfer the  same to the admissions subject*/
        ApplicationSubject.RESET;
        ApplicationSubject.SETRANGE(ApplicationSubject."Application No.", Rec."Application No.");
        IF ApplicationSubject.FIND('-') THEN BEGIN
            /*Get the last number in the admissions table*/
            AdmissionSubject.RESET;
            IF AdmissionSubject.FIND('+') THEN BEGIN
                LineNo := AdmissionSubject."Line No.";
            END
            ELSE BEGIN
                LineNo := 0;
            END;

            /*Insert the new records into the database table*/
            REPEAT
                AdmissionSubject.INIT;
                AdmissionSubject."Line No." := LineNo + 1;
                AdmissionSubject."Admission No." := NewAdminCode;
                AdmissionSubject."Subject Code" := ApplicationSubject."Subject Code";
                AdmissionSubject.Grade := AdmissionSubject.Grade;
                AdmissionSubject.INSERT();
                LineNo := LineNo + 1;
            UNTIL ApplicationSubject.NEXT = 0;
        END;
        /*Insert the medical conditions into the admission database table containing the medical condition*/
        MedicalCondition.RESET;
        MedicalCondition.SETRANGE(MedicalCondition.Mandatory, TRUE);
        IF MedicalCondition.FIND('-') THEN BEGIN
            /*Get the last line number from the medical condition table for the admissions module*/
            AdmissionMedical.RESET;
            IF AdmissionMedical.FIND('+') THEN BEGIN
                LineNo := AdmissionMedical."Line No.";
            END
            ELSE BEGIN
                LineNo := 0;
            END;
            AdmissionMedical.RESET;
            /*Loop thru the medical conditions*/
            REPEAT
                AdmissionMedical.INIT;
                AdmissionMedical."Line No." := LineNo + 1;
                AdmissionMedical."Admission No." := NewAdminCode;
                AdmissionMedical."Medical Condition Code" := MedicalCondition.Code;
                AdmissionMedical.INSERT();
                LineNo := LineNo + 1;
            UNTIL MedicalCondition.NEXT = 0;
        END;
        /*Insert the details into the family table*/
        MedicalCondition.RESET;
        MedicalCondition.SETRANGE(MedicalCondition.Mandatory, TRUE);
        MedicalCondition.SETRANGE(MedicalCondition.Family, TRUE);
        IF MedicalCondition.FIND('-') THEN BEGIN
            /*Get the last number in the family table*/
            AdmissionFamily.RESET;
            IF AdmissionFamily.FIND('+') THEN BEGIN
                LineNo := AdmissionFamily."Line No.";
            END
            ELSE BEGIN
                LineNo := 0;
            END;
            REPEAT
                AdmissionFamily.INIT;
                AdmissionFamily."Line No." := LineNo + 1;
                AdmissionFamily."Medical Condition Code" := MedicalCondition.Code;
                AdmissionFamily."Admission No." := NewAdminCode;
                AdmissionFamily.INSERT();
                LineNo := LineNo + 1;
            UNTIL MedicalCondition.NEXT = 0;
        END;

        /*Insert the immunization details into the database*/
        Immunization.RESET;
        Immunization.SETRANGE(Immunization.Mandatory, TRUE);
        /*IF Immunization.FIND('-') THEN
          BEGIN
            {Get the last line number from the database}
            //AdmissionImmunization.RESET;
            IF AdmissionImmunization.FIND('+') THEN
              BEGIN
                LineNo:=AdmissionImmunization."Line No.";
              END
            ELSE
              BEGIN
                LineNo:=0;
              END;  */
        /*loop thru the immunizations table adding the details into the admissions table for immunizations*/
        /* REPEAT
          AdmissionImmunization.INIT;
            AdmissionImmunization."Line No.":=LineNo + 1;
            AdmissionImmunization."Admission No.":= NewAdminCode ;
            AdmissionImmunization."Immunization Code":=Immunization.Code;
          AdmissionImmunization.INSERT();
         UNTIL Immunization.NEXT=0;
        END;*/

        /*Check if the user is to print*/
        IF PrintAdmission = TRUE THEN BEGIN
            // REPORT.RUN(39005702,TRUE,TRUE,Admissions)
        END;

    end;

    procedure GetCurrYear() CurrYear: Text
    var
        acadYear: Record 61382;
    begin
        acadYear.RESET;
        acadYear.SETRANGE(acadYear.Current, TRUE);
        IF acadYear.FIND('-') THEN BEGIN
            CurrYear := acadYear.Code;
        END ELSE
            ERROR('Current Academic Year not Specified!');
    end;
}

