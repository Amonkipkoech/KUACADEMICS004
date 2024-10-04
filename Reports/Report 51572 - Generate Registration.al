report 51572 "Generate Registration"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Generate Registration.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = WHERE("Customer Type" = CONST(Student),
                                      Blocked = CONST(" "));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Programme Filter", "Semester Filter", "Programme Category Filter", "Intake Filter", "Stage Filter";
            column(Customer__No__; "No.")
            {
            }
            column(Customer_Name; Name)
            {
            }
            column(Customer_NameCaption; FIELDCAPTION(Name))
            {
            }
            column(Customer__No__Caption; FIELDCAPTION("No."))
            {
            }
            dataitem("ACA-Course Registration"; "ACA-Course Registration")
            {
                DataItemLink = "Student No." = FIELD("No."),
                               Semester = FIELD("Semester Filter");
                RequestFilterFields = "Fee Exist";
            }

            trigger OnAfterGetRecord()
            begin
                RStage := '';
                StageStop := FALSE;
                StageFound := FALSE;

                CourseReg.RESET;
                CourseReg.SETCURRENTKEY(CourseReg."Reg. Transacton ID", CourseReg."Student No.");
                CourseReg.SETRANGE(CourseReg."Student No.", Customer."No.");
                CourseReg.SETFILTER(CourseReg.Semester, Customer.GETFILTER(Customer."Semester Filter"));
                CourseReg.SETFILTER(CourseReg.Programmes, Customer.GETFILTER(Customer."Programme Filter"));
                CourseReg.SETFILTER(CourseReg.Stage, Customer.GETFILTER(Customer."Stage Filter"));
                CourseReg.SETFILTER(CourseReg.Session, Customer.GETFILTER(Customer."Intake Filter"));
                CourseReg.SETFILTER(CourseReg."Programme Exam Category", GETFILTER(Customer."Programme Category Filter"));
                //CourseReg.SETFILTER(CourseReg.Semester,'<>%1',NewSem);
                IF CourseReg.FIND('+') THEN BEGIN
                    IF CourseReg.Stage <> 'Y4S2' THEN BEGIN
                        ProgStages.RESET;
                        ProgStages.SETCURRENTKEY(ProgStages."Programme Code", ProgStages.Code);
                        ProgStages.SETRANGE(ProgStages."Programme Code", CourseReg.Programmes);
                        IF ProgStages.FIND('-') THEN BEGIN
                            REPEAT
                                IF StageFound = FALSE THEN BEGIN
                                    IF StageStop = FALSE THEN BEGIN
                                        IF ProgStages.Code = CourseReg.Stage THEN
                                            StageStop := TRUE;
                                    END ELSE BEGIN
                                        RStage := ProgStages.Code;
                                        StageFound := TRUE
                                    END;
                                END;

                            UNTIL ProgStages.NEXT = 0;
                        END;

                        IF StageFound = TRUE THEN BEGIN
                            IF CourseReg."Settlement Type" <> '' THEN BEGIN

                                CourseReg3.RESET;
                                CourseReg3.SETRANGE(CourseReg3."Student No.", CourseReg."Student No.");
                                CourseReg3.SETRANGE(CourseReg3.Programmes, CourseReg.Programmes);
                                CourseReg3.SETRANGE(CourseReg3.Semester, NewSem);
                                CourseReg3.SETRANGE(CourseReg3.Stage, RStage);
                                IF CourseReg3.FIND('-') THEN BEGIN
                                    CurrReport.SKIP;
                                END ELSE BEGIN
                                    CourseReg2.INIT;
                                    CourseReg2."Reg. Transacton ID" := '';
                                    CourseReg2.VALIDATE(CourseReg2."Reg. Transacton ID");
                                    CourseReg2."Student No." := CourseReg."Student No.";
                                    CourseReg2.Programmes := CourseReg.Programmes;
                                    CourseReg2.Stage := RStage;
                                    CourseReg2."Student Type" := CourseReg."Student Type";
                                    CourseReg2.Semester := NewSem;
                                    CourseReg2."Settlement Type" := CourseReg."Settlement Type";
                                    CourseReg2."Registration Date" := TODAY;
                                    CourseReg2."System Created" := TRUE;
                                    CourseReg2."No. Series" := 'REG';
                                    CourseReg2.INSERT(TRUE);


                                    CourseReg2.RESET;
                                    CourseReg2.SETCURRENTKEY(CourseReg2."Reg. Transacton ID", CourseReg2."Student No.");
                                    CourseReg2.SETRANGE(CourseReg2."Student No.", Customer."No.");
                                    CourseReg2.SETRANGE(CourseReg2.Semester, NewSem);
                                    CourseReg2.SETRANGE(CourseReg2.Posted, FALSE);
                                    IF CourseReg2.FIND('+') THEN BEGIN
                                        CourseReg2.CALCFIELDS(CourseReg2."Fee Exist");
                                        IF CourseReg2."Fee Exist" > 0 THEN BEGIN
                                            CourseReg2.VALIDATE(CourseReg2."Registration Date");
                                            CourseReg2.VALIDATE(CourseReg2."Settlement Type");
                                            CourseReg2.MODIFY;
                                        END;
                                    END;
                                END;
                            END;


                        END;
                    END;
                END ELSE BEGIN
                    CurrReport.SKIP;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF NewSem = '' THEN
                    ERROR('Please specify the new semester.');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(NewSem; NewSem)
                {
                    Caption = 'Select the New Semester';
                    TableRelation = "ACA-Semesters".Code;
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CourseReg: Record 61532;
        CourseReg2: Record 61532;
        ProgStages: Record 61516;
        RStage: Code[20];
        StageStop: Boolean;
        StageFound: Boolean;
        NewSem: Code[20];
        CourseReg3: Record 61532;
}

