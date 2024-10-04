/// <summary>
/// Report Students Clearance (ID 51725).
/// </summary>
report 51725 "Students Clearance"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Students Clearance.rdl';

    dataset
    {
        dataitem(DataItem4392; 61357)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Student No.";
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
            column(Clearance_Header__No__; "No.")
            {
            }
            column(Clearance_Header_Date; Date)
            {
            }
            column(Clearance_Header__Student_No__; "Student No.")
            {
            }
            column(Clearance_Header__Date_Completed_; "Date Completed")
            {
            }
            column(Clearance_Header_Programme; Programme)
            {
            }
            column(Clearance_Header__Library_Clearance_ID_; "Library Clearance ID")
            {
            }
            column(Clearance_Header__Sports_Clearance_ID_; "Sports Clearance ID")
            {
            }
            column(Clearance_Header__Finance_Clearance_ID_; "Finance Clearance ID")
            {
            }
            column(Clearance_Header__Faculty_Clearance_ID_; "Registrar Clearance ID")
            {
            }
            column(Clearance_Header__Library_Cleared_; "Library Cleared")
            {
            }
            column(Clearance_Header__Sports_Cleared_; "Sports Cleared")
            {
            }
            column(Clearance_Header__Finance_Cleared_; "Finance Cleared")
            {
            }
            column(Clearance_Header__Faculty_Cleared_; "Registrar Cleared")
            {
            }
            column(Clearance_HeaderCaption; Clearance_HeaderCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Clearance_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Clearance_Header_DateCaption; FIELDCAPTION(Date))
            {
            }
            column(Clearance_Header__Student_No__Caption; FIELDCAPTION("Student No."))
            {
            }
            column(Clearance_Header__Date_Completed_Caption; FIELDCAPTION("Date Completed"))
            {
            }
            column(Clearance_Header_ProgrammeCaption; FIELDCAPTION(Programme))
            {
            }
            column(Clearance_Header__Library_Clearance_ID_Caption; FIELDCAPTION("Library Clearance ID"))
            {
            }
            column(Clearance_Header__Sports_Clearance_ID_Caption; FIELDCAPTION("Sports Clearance ID"))
            {
            }
            column(Clearance_Header__Finance_Clearance_ID_Caption; FIELDCAPTION("Finance Clearance ID"))
            {
            }
            column(Clearance_Header__Faculty_Clearance_ID_Caption; FIELDCAPTION("Registrar Clearance ID"))
            {
            }
            column(Clearance_Header__Library_Cleared_Caption; FIELDCAPTION("Library Cleared"))
            {
            }
            column(Clearance_Header__Sports_Cleared_Caption; FIELDCAPTION("Sports Cleared"))
            {
            }
            column(Clearance_Header__Finance_Cleared_Caption; FIELDCAPTION("Finance Cleared"))
            {
            }
            column(Clearance_Header__Faculty_Cleared_Caption; FIELDCAPTION("Registrar Cleared"))
            {
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

    var
        Clearance_HeaderCaptionLbl: Label 'Clearance Header';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

