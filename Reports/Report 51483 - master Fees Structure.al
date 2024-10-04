report 51483 "master Fees Structure"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/master Fees Structure.rdl';

    dataset
    {
        dataitem("ACA-Master Fee Structure"; "ACA-Master Fee Structure")
        {
            DataItemTableView = SORTING("Stage Code", Semester, "Student Type", "Settlemet Type", "Seq.");
            RequestFilterFields = "Stage Code", Semester, "Student Type", "Settlemet Type", "Seq.";
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
            column(Master_Fee_Structure__Settlemet_Type_; "Settlemet Type")
            {
            }
            column(Master_Fee_Structure_Semester; Semester)
            {
            }
            column(Master_Fee_Structure__Student_Type_; "Student Type")
            {
            }
            column(Master_Fee_Structure__Break_Down_; "Break Down")
            {
            }
            column(Master_Fee_StructureCaption; Master_Fee_StructureCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Master_Fee_Structure__Settlemet_Type_Caption; FIELDCAPTION("Settlemet Type"))
            {
            }
            column(Master_Fee_Structure_SemesterCaption; FIELDCAPTION(Semester))
            {
            }
            column(Master_Fee_Structure__Student_Type_Caption; FIELDCAPTION("Student Type"))
            {
            }
            column(Master_Student_Charges__Stage_Code_Caption; "ACA-Master Student Charges".FIELDCAPTION("Stage Code"))
            {
            }
            column(Master_Student_Charges_AmountCaption; "ACA-Master Student Charges".FIELDCAPTION(Amount))
            {
            }
            column(Master_Student_Charges_DescriptionCaption; "ACA-Master Student Charges".FIELDCAPTION(Description))
            {
            }
            column(Master_Fee_Structure__Break_Down_Caption; FIELDCAPTION("Break Down"))
            {
            }
            column(Master_Fee_Structure_Stage_Code; "Stage Code")
            {
            }
            column(Master_Fee_Structure_Seq_; "Seq.")
            {
            }
            dataitem("ACA-Master Student Charges"; "ACA-Master Student Charges")
            {
                DataItemLink = "Student Type" = FIELD("Student Type");
                column(Master_Student_Charges_Description; Description)
                {
                }
                column(Master_Student_Charges_Amount; Amount)
                {
                }
                column(Master_Student_Charges__Stage_Code_; "Stage Code")
                {
                }
                column(Master_Student_Charges_Code; Code)
                {
                }
                column(Master_Student_Charges_Student_Type; "Student Type")
                {
                }
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
        Master_Fee_StructureCaptionLbl: Label 'Master Fee Structure';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
}

