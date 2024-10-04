report 69286 "KUCCPS & PSSP Adm. By Program"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/KUCCPS & PSSP Adm. By Program.rdl';

    dataset
    {
        dataitem("ACA-Programme"; 61511)
        {
            PrintOnlyIfDetail = true;
            column(ProgCode; "ACA-Programme".Code)
            {
            }
            column(ProgDesc; "ACA-Programme".Description)
            {
            }
            column(AdminJAB; "ACA-Programme"."Admissions JAB")
            {
            }
            column(AdminSSP; "ACA-Programme"."Admissions SSP")
            {
            }
            column(AdmisJabFem; "ACA-Programme"."Admissions JAB Female")
            {
            }
            column(AdmisJabMal; "ACA-Programme"."Admissions JAB Male")
            {
            }
            column(AdmisSSPFem; "ACA-Programme"."Admissions SSP Female")
            {
            }
            column(AdmisSSPMal; "ACA-Programme"."Admissions SSP Male")
            {
            }
            column(TotFemale; "ACA-Programme"."Admissions JAB Female" + "ACA-Programme"."Admissions SSP Female")
            {
            }
            column(TotMale; "ACA-Programme"."Admissions JAB Male" + "ACA-Programme"."Admissions SSP Male")
            {
            }
            column(TotStudents; "ACA-Programme"."Admissions JAB" + "ACA-Programme"."Admissions SSP")
            {
            }
            dataitem("ACA-Applic. Form Header"; 61358)
            {
                DataItemLink = "Admitted Degree" = FIELD(Code);
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
                        IF NewProg THEN seq := 0;
                        NewProg := FALSE;
                        seq := seq + 1;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                NewProg := TRUE;
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
        NewProg: Boolean;
}

