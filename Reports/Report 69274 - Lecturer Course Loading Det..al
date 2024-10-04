report 69274 "Lecturer Course Loading Det."
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Lecturer Course Loading Det..rdl';

    dataset
    {
        dataitem(DataItem1000000000; 61511)
        {
            DataItemTableView = SORTING(Code)
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompPhones; CompanyInformation."Phone No." + '\' + CompanyInformation."Phone No. 2")
            {
            }
            column(CompMails; CompanyInformation."Home Page" + '\' + CompanyInformation."E-Mail")
            {
            }
            column(CompAddresses; CompanyInformation.Address + '\' + CompanyInformation."Address 2" + ' - ' + CompanyInformation.City)
            {
            }
            column(ProgCode; prog.Code)
            {
            }
            column(ProgDescription; prog.Description)
            {
            }
            column(fliters; filters)
            {
            }
            dataitem(DataItem1000000060; 61516)
            {
                DataItemLink = "Programme Code" = FIELD(Code);
                DataItemTableView = SORTING("Programme Code", Code)
                                    ORDER(Ascending);
                PrintOnlyIfDetail = true;
                column(StagesCode; progstage.Code)
                {
                }
                column(StageDescription; progstage.Description)
                {
                }
                column(fliters2; filters2)
                {
                }
                dataitem(DataItem1000000032; 65202)
                {
                    DataItemLink = Programme = FIELD("Programme Code"),
                                   Stage = FIELD(Code);
                    RequestFilterFields = Programme, Stage, Semester;
                    column(EmpNames; HRMEmployeeC."First Name" + ' ' + HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name")
                    {
                    }
                    column(Salutations; FORMAT(HRMEmployeeC.Title))
                    {
                    }
                    column(SemesterDesc; ACASemester.Description)
                    {
                    }
                    column(Lname; HRMEmployeeC."Last Name")
                    {
                    }
                    column(fName; HRMEmployeeC."First Name")
                    {
                    }
                    column(MName; HRMEmployeeC."Middle Name")
                    {
                    }
                    column(UnitStage; units.Stage)
                    {
                    }
                    column(UnitProg; units.Programme)
                    {
                    }
                    column(UnitCode; units.Unit)
                    {
                    }
                    column(Lect; units.Lecturer)
                    {
                    }
                    column(UnitDesc; units.Description)
                    {
                    }
                    column(UnitCost; units."Unit Cost")
                    {
                    }
                    column(MarksSubmitted; units."Marks Submitted")
                    {
                    }
                    column(AngagementTerms; units."Engagement Terms")
                    {
                    }
                    column(ExamsSubmitted; units."Exams Submitted")
                    {
                    }
                    column(CatsSubmitted; units."CATs Submitted")
                    {
                    }
                    column(Approved; units.Approved)
                    {
                    }
                    column(seq; seq)
                    {
                    }
                    column(fliters3; filters3)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        HRMEmployeeC.RESET;
                        HRMEmployeeC.SETRANGE("No.", units.Lecturer);
                        IF HRMEmployeeC.FIND('-') THEN BEGIN
                        END;
                        ACASemester.RESET;
                        ACASemester.SETRANGE(Code, units.Semester);
                        IF ACASemester.FIND('-') THEN
                            ACASemester.VALIDATE(ACASemester.Description);
                        seq := seq + 1;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CLEAR(filters3);
                        filters3 := units.GETFILTERS;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CLEAR(seq);
                end;

                trigger OnPreDataItem()
                begin
                    CLEAR(filters2);
                    filters2 := progstage.GETFILTERS;
                end;
            }

            trigger OnPreDataItem()
            begin
                CLEAR(filters);
                filters := prog.GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
        END;
    end;

    var
        progstage: Record "ACA-Programme Stages";
        units: Record "ACA-Lecturers Units";
        prog: Record "ACA-Programme";
        CompanyInformation: Record 79;
        HRMEmployeeC: Record 61188;
        ACASemester: Record 61692;
        seq: Integer;
        LectLoadBatchLines: Record 65201;
        "Lect Load Batch Lines": Record 65201;
        filters: Text[1024];
        filters2: Text[1024];
        filters3: Text[1024];
}

