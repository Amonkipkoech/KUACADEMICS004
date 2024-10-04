report 69285 "KUCCPS & PSSP Admissions List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KUCCPS & PSSP Admissions List.rdl';

    dataset
    {
        dataitem("ACA-Applic. Form Header"; 61358)
        {
            column(CompName; info.Name)
            {
            }
            column(Address1; info.Address)
            {
            }
            column(Address2; info."Address 2")
            {
            }
            column(City; info.City)
            {
            }
            column(Phone1; info."Phone No.")
            {
            }
            column(Phone2; info."Phone No. 2")
            {
            }
            column(Fax; info."Fax No.")
            {
            }
            column(Pic; info.Picture)
            {
            }
            column(postCode; info."Post Code")
            {
            }
            column(CompEmail; info."E-Mail")
            {
            }
            column(HomePage; info."Home Page")
            {
            }
            column(seq; seq)
            {
            }
            column(AppLicNo; "ACA-Applic. Form Header"."Application No.")
            {
            }
            column(AdmisnNo; "ACA-Applic. Form Header"."Admission No")
            {
            }
            column(AdmittedDegree; "ACA-Applic. Form Header"."Admitted Degree")
            {
            }
            column(AdmittedStage; "ACA-Applic. Form Header"."Admitted To Stage")
            {
            }
            column(AdmittedSem; "ACA-Applic. Form Header"."Admitted Semester")
            {
            }
            column(SurName; "ACA-Applic. Form Header".Surname)
            {
            }
            column(OtherNames; "ACA-Applic. Form Header"."Other Names")
            {
            }
            column(Gender; "ACA-Applic. Form Header".Gender)
            {
            }
            column(IndexNo; "ACA-Applic. Form Header"."Index Number")
            {
            }
            column(sems; Sems)
            {
            }
            column(IntakeCode; "ACA-Applic. Form Header"."Intake Code")
            {
            }
            column(ModeOfStudy; "ACA-Applic. Form Header"."Mode of Study")
            {
            }
            column(FirstChoiceCat; "ACA-Applic. Form Header"."First Choice Category")
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF "ACA-Applic. Form Header"."First Choice Semester" <> Sems THEN
                    CurrReport.SKIP ELSE BEGIN
                    seq := seq + 1;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(FiltApplic)
                {
                    Caption = 'Apply FIlters Here';
                    field(Semes; Sems)
                    {
                        Caption = 'Semester';
                        TableRelation = "ACA-Semesters".Code;
                        ApplicationArea = All;
                    }
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

    trigger OnPreReport()
    begin
        IF info.GET() THEN BEGIN
            info.CALCFIELDS(Picture);
        END;
        CLEAR(seq);
        IF Sems = '' THEN ERROR('Specify the Semester');
    end;

    var
        info: Record 79;

        Sems: Code[20];
        seq: Integer;
}

