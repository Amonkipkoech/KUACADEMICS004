report 51341 "Applications Deans Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Applications Deans Summary.rdl';

    dataset
    {
        dataitem("ACA-Applic. Form Header"; 61358)
        {
            DataItemTableView = SORTING(School1)
                                WHERE(Status = FILTER("Pending Approval"));
            RequestFilterFields = "Application No.", Status, "Admitted Degree", "Academic Year";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(Subj_1_; Subj[1])
            {
            }
            column(Subj_2_; Subj[2])
            {
            }
            column(Subj_4_; Subj[4])
            {
            }
            column(Subj_3_; Subj[3])
            {
            }
            column(Subj_6_; Subj[6])
            {
            }
            column(Subj_5_; Subj[5])
            {
            }
            column(Subj_8_; Subj[8])
            {
            }
            column(Subj_7_; Subj[7])
            {
            }
            column(Subj_10_; Subj[10])
            {
            }
            column(Subj_9_; Subj[9])
            {
            }
            column(Application_Form_Header_Faculty1; School1)
            {
            }
            column(Application_Form_Header__Application_No__; "Application No.")
            {
            }
            column(Application_Form_Header_Surname; Surname)
            {
            }
            column(Application_Form_Header__Other_Names_; "Other Names")
            {
            }
            column(Application_Form_Header_County; County)
            {
            }
            column(Application_Form_Header_Gender; Gender)
            {
            }
            column(Application_Form_Header__Mean_Grade_Acquired_; "Mean Grade Acquired")
            {
            }
            column(Gr_1_; Gr[1])
            {
            }
            column(Gr_2_; Gr[2])
            {
            }
            column(Gr_3_; Gr[3])
            {
            }
            column(Gr_6_; Gr[6])
            {
            }
            column(Gr_5_; Gr[5])
            {
            }
            column(Gr_4_; Gr[4])
            {
            }
            column(Gr_9_; Gr[9])
            {
            }
            column(Gr_8_; Gr[8])
            {
            }
            column(Gr_7_; Gr[7])
            {
            }
            column(Gr_10_; Gr[10])
            {
            }
            column(N; N)
            {
            }
            column(Deans_SummaryCaption; Deans_SummaryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Application_Form_Header__Application_No__Caption; FIELDCAPTION("Application No."))
            {
            }
            column(Application_Form_Header_SurnameCaption; FIELDCAPTION(Surname))
            {
            }
            column(Application_Form_Header__Other_Names_Caption; FIELDCAPTION("Other Names"))
            {
            }
            column(Application_Form_Header_CountyCaption; FIELDCAPTION(County))
            {
            }
            column(Application_Form_Header_GenderCaption; FIELDCAPTION(Gender))
            {
            }
            column(Application_Form_Header__Mean_Grade_Acquired_Caption; FIELDCAPTION("Mean Grade Acquired"))
            {
            }
            column(RemarksCaption; RemarksCaptionLbl)
            {
            }
            column(Application_Form_Header_Faculty1Caption; FIELDCAPTION(School1))
            {
            }

            trigger OnAfterGetRecord()
            begin
                FOR i := 1 TO 20 DO BEGIN
                    AppSubj.RESET;
                    AppSubj.SETRANGE(AppSubj."Application No.", "ACA-Applic. Form Header"."Application No.");
                    AppSubj.SETRANGE(AppSubj."Subject Code", Subj[i]);
                    IF AppSubj.FIND('-') THEN BEGIN
                        REPEAT
                            Gr[i] := AppSubj.Grade;
                        UNTIL AppSubj.NEXT = 0;
                    END;
                END;

                N := N + 1;
            end;

            trigger OnPreDataItem()
            begin
                SubjSetup.RESET;
                SubjSetup.SETCURRENTKEY(SubjSetup."Sort No");
                IF SubjSetup.FIND('-') THEN BEGIN
                    REPEAT
                        IF SubjSetup."Sort No" > 0 THEN BEGIN
                            i := i + 1;
                            IF i < 20 THEN
                                Subj[i] := SubjSetup.Code;
                        END;
                    UNTIL SubjSetup.NEXT = 0;
                END;
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

    var
        Subj: array[20] of Code[20];
        Gr: array[20] of Code[20];
        SubjSetup: Record 61363;
        AppSubj: Record 61362;
        i: Integer;
        N: Integer;
        Deans_SummaryCaptionLbl: Label 'Deans Summary';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        RemarksCaptionLbl: Label 'Remarks';
}

