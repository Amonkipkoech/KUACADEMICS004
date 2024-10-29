page 86012 "ACA-Certificates Issued"
{
    Caption = 'ACA-Certificates Issued';
    CardPageId = "Cert Issued Card";
    PageType = List;
    SourceTable = "Certificate Issuance";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field("Certificate No"; Rec."Certificate No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Certificate No field.', Comment = '%';
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student No. field.', Comment = '%';
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Student Name field.', Comment = '%';
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Department field.', Comment = '%';
                }
                field(School; Rec.School)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School field.', Comment = '%';
                }
                field("Date Issued"; Rec."Date Issued")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Issued field.', Comment = '%';
                }
                field("Certficate issued By"; Rec."Certficate issued By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Certficate issued By field.', Comment = '%';
                }
            }
        }
    }
}
