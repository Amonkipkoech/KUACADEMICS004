report 51365 "Shortlisted Students Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Shortlisted Students Summary.rdl';

    dataset
    {
        dataitem("ACA-Applic. Form Header"; "ACA-Applic. Form Header")
        {
            DataItemTableView = SORTING("Application No.");
            RequestFilterFields = "Application No.";
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
            column(Application_Form_Header__Application_No__; "Application No.")
            {
            }
            column(Surname_________Other_Names_; Surname + ' ' + "Other Names")
            {
            }
            column(Application_Form_Header__First_Degree_Choice_; "First Degree Choice")
            {
            }
            column(Application_Form_Header__Mean_Grade_Acquired_; "Mean Grade Acquired")
            {
            }
            column(Application_Form_Header__Points_Acquired_; "Points Acquired")
            {
            }
            column(GradeReqd; GradeReqd)
            {
            }
            column(PointsReqd; PointsReqd)
            {
            }
            column(AdmStatus; AdmStatus)
            {
            }
            column(Application_Form_HeaderCaption; Application_Form_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Application_Form_Header__Application_No__Caption; FIELDCAPTION("Application No."))
            {
            }
            column(Applicant_s_nameCaption; Applicant_s_nameCaptionLbl)
            {
            }
            column(Application_Form_Header__First_Degree_Choice_Caption; FIELDCAPTION("First Degree Choice"))
            {
            }
            column(Application_Form_Header__Mean_Grade_Acquired_Caption; FIELDCAPTION("Mean Grade Acquired"))
            {
            }
            column(Application_Form_Header__Points_Acquired_Caption; FIELDCAPTION("Points Acquired"))
            {
            }
            column(Mean_Grade_RequiredCaption; Mean_Grade_RequiredCaptionLbl)
            {
            }
            column(Points_RequiredCaption; Points_RequiredCaptionLbl)
            {
            }
            column(StatusCaption; StatusCaptionLbl)
            {
            }
            dataitem("ACA-Applic. Form Academic"; "ACA-Applic. Form Academic")
            {
                DataItemLink = "Application No." = FIELD("Application No.");

                trigger OnAfterGetRecord()
                begin
                    SubGradeReqd := '';
                    SubjectStatus := 'PASSED';
                    SubPoints := 0;
                    SubGrade.RESET;
                    SubGrade.SETRANGE(SubGrade.Programme, "ACA-Applic. Form Header"."First Degree Choice");
                    SubGrade.SETRANGE(SubGrade."Subject Code", "ACA-Applic. Form Academic"."Subject Code");
                    IF SubGrade.FIND('-') THEN BEGIN
                        SubGradeReqd := SubGrade."Mean Grade";
                        recGrade.RESET;
                        recGrade.GET(SubGradeReqd);
                        SubPoints := recGrade.Points;
                        recGrade.RESET;
                        IF recGrade.GET("ACA-Applic. Form Academic".Grade) THEN BEGIN
                            IF SubPoints > recGrade.Points THEN BEGIN
                                SubjectStatus := 'FAILED';
                            END
                            ELSE BEGIN
                                SubjectStatus := 'PASSED';
                            END;
                        END;

                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                GradeReqd := '';
                PointsReqd := 0;
                AdmStatus := 'FAILED';
                ProgGrade.RESET;
                ProgGrade.SETRANGE(ProgGrade.Programme, "ACA-Applic. Form Header"."First Degree Choice");
                IF ProgGrade.FIND('-') THEN BEGIN
                    GradeReqd := ProgGrade."Mean Grade";
                    PointsReqd := ProgGrade."Min Points";
                    IF PointsReqd > "ACA-Applic. Form Header"."Points Acquired" THEN BEGIN
                        AdmStatus := 'FAILED';
                    END
                    ELSE BEGIN
                        AdmStatus := 'PASSED';
                    END;
                END;
            end;

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Application No.");
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
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        GradeReqd: Code[20];
        PointsReqd: Integer;
        AdmStatus: Text[30];
        ProgGrade: Record 61384;
        SubGradeReqd: Code[20];
        SubjectStatus: Text[30];
        SubGrade: Record 61385;
        SubPoints: Integer;
        recGrade: Record 61364;
        Application_Form_HeaderCaptionLbl: Label 'Application Form Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Applicant_s_nameCaptionLbl: Label 'Applicant''s name';
        Mean_Grade_RequiredCaptionLbl: Label 'Mean Grade Required';
        Points_RequiredCaptionLbl: Label 'Points Required';
        StatusCaptionLbl: Label 'Status';
}

