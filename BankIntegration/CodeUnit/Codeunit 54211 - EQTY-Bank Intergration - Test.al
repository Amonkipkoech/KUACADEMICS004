codeunit 54211 "EQTY-Bank Intergration - Test"
{

    trigger OnRun()
    begin
    end;

    procedure ValidateAccount(incustomerRefNumber: Code[20]) AccountStatus: Text[250]
    var
        Cust: Record Customer;
        BankIntergration: Record "KCB Bank Intergration - Test";
    begin
        Clear(AccountStatus);
        Cust.Reset;
        Cust.SetRange("No.", incustomerRefNumber);
        if not Cust.Find('-') then begin
            //Student Does Not Exist
            AccountStatus := 'ERROR: Invalid Student number';
            //EXIT;
        end else begin
            //Student Exists
            AccountStatus := Cust.Name;
        end;
    end;

    procedure GetPayTrans(inbankreference: Code[50]; indebitaccount: Code[20]; intransactionDate: Code[20]; inbillAmount: Code[20]; inpaymentMode: Code[20]; inphonenumber: Code[20]; incustomerRefNumber: Code[20]; indebitcustname: Text[150]) Status: Text[250]
    var
        Cust: Record Customer;
        BankIntergration: Record "Bank Intergration - Test";
    begin
        Clear(Status);
        Cust.Reset;
        Cust.SetRange("No.", incustomerRefNumber);
        if not Cust.Find('-') then begin
            //Student Does Not Exist
            Status := 'Failed, ' + incustomerRefNumber + ' Does not exist';
            //EXIT;
        end else begin
            //Student Exists
            BankIntergration.Reset;
            BankIntergration.SetRange(bankreference, inbankreference);
            if BankIntergration.Find('-') then begin
                //The Transaction Already Exists
                Status := 'FAILED: Transaction ' + inbankreference + ' Already Exists';
            end else begin
                //The Transaction Does Not Exist
                BankIntergration.Init;
                BankIntergration.bankreference := inbankreference;
                BankIntergration.customerRefNumber := incustomerRefNumber;
                BankIntergration.debitaccount := indebitcustname;
                BankIntergration.debitcustname := indebitcustname;
                BankIntergration.paymentMode := inpaymentMode;
                BankIntergration.transactionDate := intransactionDate;
                BankIntergration.phonenumber := inphonenumber;
                BankIntergration.billAmount := inbillAmount;
                BankIntergration.Insert;
                Status := 'SUCCESSFUL';
            end;
        end;
    end;

    local procedure PostReceipt()
    begin
    end;
}

