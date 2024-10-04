report 51652 "Receipt - Student-TEST"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Receipt - Student-TEST.rdl';

    dataset
    {
        dataitem(DataItem5672; 61538)
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Receipt No.";
            column(Receipt__Receipt_No__; "Receipt No.")
            {
            }
            column(Names; Names)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(Receipt_Amount; Amount)
            {
            }
            column(Receipt__Student_No__; "Student No.")
            {
            }
            column(Cust_Balance__Amount_Applied_; Cust.Balance + "Amount Applied")
            {
            }
            column(PDescription1; PDescription1)
            {
            }
            column(pAmount1; pAmount1)
            {
            }
            column(pCode1; pCode1)
            {
            }
            column(Receipt__Amount_Applied_; "Amount Applied")
            {
            }
            column(Cust_Balance; Cust.Balance)
            {
            }
            column(RegCourse; RegCourse)
            {
            }
            column(pCode2; pCode2)
            {
            }
            column(pCode3; pCode3)
            {
            }
            column(pCode4; pCode4)
            {
            }
            column(PDescription2; PDescription2)
            {
            }
            column(PDescription3; PDescription3)
            {
            }
            column(PDescription4; PDescription4)
            {
            }
            column(pAmount2; pAmount2)
            {
            }
            column(pAmount3; pAmount3)
            {
            }
            column(pAmount4; pAmount4)
            {
            }
            column(pCode5; pCode5)
            {
            }
            column(pCode6; pCode6)
            {
            }
            column(pCode7; pCode7)
            {
            }
            column(PDescription5; PDescription5)
            {
            }
            column(PDescription6; PDescription6)
            {
            }
            column(PDescription7; PDescription7)
            {
            }
            column(pAmount5; pAmount5)
            {
            }
            column(pAmount6; pAmount6)
            {
            }
            column(pAmount7; pAmount7)
            {
            }
            column(Receipt__Receipt_No__Caption; FIELDCAPTION("Receipt No."))
            {
            }
            column(DATE_TIMECaption; DATE_TIMECaptionLbl)
            {
            }
            // column(DataItem1000000015; "Thank_you_for_training_Please_keep_your_latest_receipt_safely_you_may_be_asked_to_produce_it_before_proceeding_to_yoLbl")
            // {
            // }
            column(Received_FromCaption; Received_FromCaptionLbl)
            {
            }
            column(Reg__No_Caption; Reg__No_CaptionLbl)
            {
            }
            column(Class_SessionCaption; Class_SessionCaptionLbl)
            {
            }
            column(being_payment_forCaption; being_payment_forCaptionLbl)
            {
            }
            column(Amount_PayableCaption; Amount_PayableCaptionLbl)
            {
            }
            column(Total_PaidCaption; Total_PaidCaptionLbl)
            {
            }
            column(Outstanding_BalanceCaption; Outstanding_BalanceCaptionLbl)
            {
            }
            column(Course_RegisteredCaption; Course_RegisteredCaptionLbl)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Hesabu := 0;
                tAmount := 0;
                Cust.RESET;
                IF Cust.GET("Student No.") THEN BEGIN
                    Cust.CALCFIELDS(Cust.Balance);
                    Names := Cust.Name;
                END;
                CourseReg.RESET;
                CourseReg.SETRANGE(CourseReg."Student No.", "Student No.");
                IF CourseReg.FIND('-') THEN
                    RegCourse := CourseReg.Programmes;
                RecItems.RESET;
                RecItems.SETRANGE(RecItems."Receipt No", "Receipt No.");
                IF RecItems.FIND('-') THEN BEGIN
                    Hesabu := 1;
                    REPEAT
                        IF Hesabu = 1 THEN BEGIN
                            pCode1 := RecItems.Code;
                            PDescription1 := RecItems.Description;
                            pAmount1 := RecItems.Amount;
                        END;
                        IF Hesabu = 2 THEN BEGIN
                            pCode2 := RecItems.Code;
                            PDescription2 := RecItems.Description;
                            pAmount2 := RecItems.Amount;
                        END;
                        IF Hesabu = 3 THEN BEGIN
                            pCode3 := RecItems.Code;
                            PDescription3 := RecItems.Description;
                            pAmount3 := RecItems.Amount;
                        END;
                        IF Hesabu = 4 THEN BEGIN
                            pCode4 := RecItems.Code;
                            PDescription4 := RecItems.Description;
                            pAmount4 := RecItems.Amount;
                        END;
                        Hesabu := Hesabu + 1;
                    UNTIL RecItems.NEXT = 0;
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
        Cust: Record 18;
        Names: Text[200];
        RecItems: Record 61539;
        pCode1: Code[20];
        PDescription1: Text[50];
        pAmount1: Decimal;
        tAmount: Decimal;
        RegCourse: Text[50];
        CourseReg: Record 61532;
        pAmount2: Decimal;
        pCode2: Code[20];
        pCode3: Code[20];
        pCode4: Code[20];
        PDescription2: Text[50];
        PDescription3: Text[50];
        PDescription4: Text[50];
        pAmount3: Decimal;
        pAmount4: Decimal;
        Hesabu: Integer;
        pAmount5: Decimal;
        pAmount6: Decimal;
        pAmount7: Decimal;
        pCode5: Code[20];
        pCode6: Code[20];
        pCode7: Code[20];
        PDescription5: Text[50];
        PDescription6: Text[50];
        PDescription7: Text[50];
        DATE_TIMECaptionLbl: Label 'DATE/TIME';
        //Thank_you_for_training_with_KCA_Please_keep_your_latest_receipt_safely_you_may_be_asked_to_produce_it_before_proceeding_to_yoLbl: Label 'Thank you for training with KCA.Please keep your latest receipt safely,you may be asked to produce it before proceeding to your class';
        Received_FromCaptionLbl: Label 'Received From';
        Reg__No_CaptionLbl: Label 'Reg. No.';
        Class_SessionCaptionLbl: Label 'Class Session';
        being_payment_forCaptionLbl: Label 'being payment for';
        Amount_PayableCaptionLbl: Label 'Amount Payable';
        Total_PaidCaptionLbl: Label 'Total Paid';
        Outstanding_BalanceCaptionLbl: Label 'Outstanding Balance';
        Course_RegisteredCaptionLbl: Label 'Course Registered';
}

