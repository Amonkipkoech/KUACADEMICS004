report 51323 "Post Graduate Status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Post Graduate Status.rdl';

    dataset
    {
        dataitem("ACA-Post Grad Change History"; "ACA-Post Grad Change History")
        {
            DataItemTableView = SORTING("Student No");
            RequestFilterFields = "Student No";
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
            column(Post_Grad_Change_History__Student_No_; "Student No")
            {
            }
            column(Post_Grad_Change_History__Programme_Code_; "Programme Code")
            {
            }
            column(Post_Grad_Change_History_Code; Code)
            {
            }
            column(Post_Grad_Change_History_Status; Status)
            {
            }
            column(Post_Grad_Change_History_Date; Date)
            {
            }
            column(Post_Grad_Change_History__Status_Type_; "Status Type")
            {
            }
            column(Post_Graduate_Change_HistoryCaption; Post_Graduate_Change_HistoryCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Post_Grad_Change_History_CodeCaption; FIELDCAPTION(Code))
            {
            }
            column(Post_Grad_Change_History_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Post_Grad_Change_History_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Post_Grad_Change_History__Status_Type_Caption; FIELDCAPTION("Status Type"))
            {
            }
            column(Post_Grad_Change_History__Student_No_Caption; FIELDCAPTION("Student No"))
            {
            }
            column(Post_Grad_Change_History__Programme_Code_Caption; FIELDCAPTION("Programme Code"))
            {
            }
            column(Post_Grad_Change_History_Line_No; "Line No")
            {
            }

            trigger OnPreDataItem()
            begin
                LastFieldNo := FIELDNO("Student No");
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
        Post_Graduate_Change_HistoryCaptionLbl: Label 'Post Graduate Change History';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

