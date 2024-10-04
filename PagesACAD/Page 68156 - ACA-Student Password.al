page 68156 "ACA-Student Password"
{
    Caption = 'Student Password';
    PageType = StandardDialog;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            field(StudentNo; StudentNo)
            {
                Caption = 'Student No.';
                ApplicationArea = All;
            }
            field(Password; Password)
            {
                Caption = 'Password';
                ExtendedDatatype = Masked;
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    //IF SetPassword <> ConfirmPassword THEN
                    //  ERROR(Text001);
                    //IF NOT IdentityManagement.ValidatePasswordStrength(Password) THEN
                    //  ERROR(Text002);
                end;
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        IF CloseAction = ACTION::OK THEN BEGIN
            Cust.RESET;
            Cust.SETRANGE(Cust."No.", StudentNo);
            IF Cust.FIND('-') THEN BEGIN
                IF Cust.Password = Password THEN
                    PAGE.RUN(39005613, Cust)
                ELSE
                    ERROR('Invalid Password ');
            END ELSE BEGIN
                ERROR('Invalid Student Number');
            END;
        END
    end;

    var
        Text001: Label 'The passwords that you entered did not match.';
        Text002: Label 'The password that you entered does not meet the minimum requirements. It must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one number.';
        IdentityManagement: Codeunit 9801;
        [InDataSet]
        Password: Text[250];
        [InDataSet]
        ConfirmPassword: Text[250];
        Cust: Record 18;
        StudentNo: Code[20];
}

