report 51347 "Graduation Tracker"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/graduationTracker.rdl';

    dataset
    {
        dataitem(cust; Customer)
        {
            RequestFilterFields = "No.";
            dataitem(prog; "ACA-Programme")
            {
                DataItemTableView = SORTING(Code);
                RequestFilterFields = "Code";
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(COMPANYNAME; COMPANYNAME)
                {
                }
               
                column(USERID; USERID)
                {
                }
                column(Programme_Code; Code)
                {
                }
                column(Programme_Code_Control1102756011; Code)
                {
                }
                column(pic; info.Picture)
                {
                }
                column(Programme_Description; Description)
                {
                }
                column(ProgrammeCaption; ProgrammeCaptionLbl)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(Programme_Code_Control1102756011Caption; FIELDCAPTION(Code))
                {
                }
                column(Programme_DescriptionCaption; FIELDCAPTION(Description))
                {
                }
                column(Programme_CodeCaption; FIELDCAPTION(Code))
                {
                }
                dataitem(stages; 61516)
                {
                    DataItemLink = "Programme Code" = FIELD(Code);
                    column(StaGeCode; stages.Code)
                    {
                    }
                    column(StageDesc; stages.Description)
                    {
                    }
                    dataitem("ACA-Units/Subjects"; "ACA-Units/Subjects")
                    {
                        DataItemLink = "Programme Code" = FIELD("Programme Code"),
                                  "Stage Code" = FIELD(Code);
                        column(UnitCode; "ACA-Units/Subjects".Code)
                        {
                        }
                        column(UnitDesc; "ACA-Units/Subjects".Desription)
                        {
                        }
                        column(UnitCreditHrs; "ACA-Units/Subjects"."Credit Hours")
                        {
                        }
                        column(Status; Status)
                        {

                        }
                        trigger OnAfterGetRecord()
                        begin
                            courseReg.Reset();
                            courseReg.SetRange("Student No.", cust."No.");
                            courseReg.SetRange(Semester, GetCurrentSemester());
                            if courseReg.Find('-') then begin
                                prog.Reset();
                                prog.SetRange(Code, courseReg.Programmes);
                                if prog.Find('-') then begin
                                    examRes.Reset();
                                    examRes.SetRange(StudentID, cust."No.");
                                    examRes.SetFilter(examRes.MeanGrade, '%1|%2|%3|%4', 'A', 'B', 'C', 'D');
                                    if examRes.Find('-') then begin
                                        repeat
                                            "ACA-Units/Subjects".Reset();
                                            "ACA-Units/Subjects".SetRange(Code, examRes.UnitCode);
                                            if "ACA-Units/Subjects".Find('-') then begin
                                                Status := 'COMPLETED'
                                            end else
                                                Status := 'PENDING';
                                        until examRes.Next() = 0;
                                    end;

                                end;
                            end;
                        end;
                    }
                }

                trigger OnPreDataItem()
                begin
                    LastFieldNo := FIELDNO(Code);
                end;
            }
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

    trigger OnPreReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN info.CALCFIELDS(Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        ProgrammeCaptionLbl: Label 'Programme';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        info: Record 79;
        CurrentSem: Record "ACA-Semesters";
        courseReg: Record "ACA-Course Registration";
        examRes: Record "Final Exam Result2";
        Status: Text;

    procedure GetCurrentSemester() Message: Code[20]
    begin
        CurrentSem.RESET;
        CurrentSem.SETRANGE("Current Semester", TRUE);
        IF CurrentSem.FIND('-') THEN BEGIN
            Message := CurrentSem.Code;
        END;
    end;
}

