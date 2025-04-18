tableextension 70001 Customers extends Customer
{

    Caption = 'Customer';
    LookupPageID = 22;
    fields
    {
        modify("No.")
        {
            Caption = 'No.';
        }
        modify(Name)
        {

            //Unsupported feature: Property Modification (Data type) on "Name(Field 2)".

            Caption = 'Name';
        }
        modify("Search Name")
        {

            //Unsupported feature: Property Modification (Data type) on ""Search Name"(Field 3)".

            Caption = 'Search Name';
        }
        modify("Name 2")
        {
            Caption = 'Name 2';
        }
        modify(Address)
        {

            //Unsupported feature: Property Modification (Data type) on "Address(Field 5)".

            Caption = 'Address';
        }
        modify("Address 2")
        {
            Caption = 'Address 2';
        }
        modify(City)
        {
            Caption = 'City';
        }
        modify(Contact)
        {

            //Unsupported feature: Property Modification (Data type) on "Contact(Field 8)".

            Caption = 'Contact';
        }
        modify("Phone No.")
        {
            Caption = 'Primary Mobile';
        }
        modify("Telex No.")
        {
            Caption = 'Telex No.';
        }
        modify("Document Sending Profile")
        {
            Caption = 'Document Sending Profile';
        }
        modify("Our Account No.")
        {
            Caption = 'Our Account No.';
        }
        modify("Territory Code")
        {
            Caption = 'Territory Code';
        }
        modify("Global Dimension 1 Code")
        {
            TableRelation = "Dimension Value".Code; //WHERE ("Dimension Code"=FILTER("Department Code"));
            Caption = 'Global Dimension 1 Code';
        }
        modify("Global Dimension 2 Code")
        {
            Caption = 'Global Dimension 2 Code';
        }
        modify("Chain Name")
        {
            Caption = 'Chain Name';
        }
        modify("Budgeted Amount")
        {
            Caption = 'Budgeted Amount';
        }
        modify("Credit Limit (LCY)")
        {
            Caption = 'Credit Limit ($)';
        }
        modify("Customer Posting Group")
        {
            Caption = 'Customer Posting Group';
        }
        modify("Currency Code")
        {
            Caption = 'Currency Code';
        }
        modify("Customer Price Group")
        {
            Caption = 'Customer Price Group';
        }
        modify("Language Code")
        {
            Caption = 'Language Code';
        }
        modify("Statistics Group")
        {
            Caption = 'Statistics Group';
        }
        modify("Payment Terms Code")
        {
            Caption = 'Payment Terms Code';
        }
        modify("Fin. Charge Terms Code")
        {
            Caption = 'Fin. Charge Terms Code';
        }
        modify("Salesperson Code")
        {
            Caption = 'Salesperson Code';
        }
        modify("Shipment Method Code")
        {
            Caption = 'Shipment Method Code';
        }
        modify("Shipping Agent Code")
        {
            Caption = 'Shipping Agent Code';
        }
        modify("Place of Export")
        {
            Caption = 'Place of Export';
        }
        modify("Invoice Disc. Code")
        {
            Caption = 'Invoice Disc. Code';
        }
        modify("Customer Disc. Group")
        {
            Caption = 'Customer Disc. Group';
        }
        modify("Country/Region Code")
        {
            Caption = 'Country/Region Code';
        }
        modify("Collection Method")
        {
            Caption = 'Collection Method';
        }
        modify(Amount)
        {
            Caption = 'Amount';
        }
        modify(Comment)
        {
            Caption = 'Comment';
        }
        modify(Blocked)
        {
            Caption = 'Blocked';

            // OptionCaption = 'Ship Invoice All';

        }
        modify("Invoice Copies")
        {
            Caption = 'Invoice Copies';
        }
        modify("Last Statement No.")
        {
            Caption = 'Last Statement No.';
        }
        modify("Print Statements")
        {
            Caption = 'Print Statements';
        }
        modify("Bill-to Customer No.")
        {
            Caption = 'Bill-to Customer No.';
        }
        modify(Priority)
        {
            Caption = 'Priority';
        }
        modify("Payment Method Code")
        {
            Caption = 'Payment Method Code';
        }
        modify("Last Modified Date Time")
        {
            Caption = 'Last Modified Date Time';
        }
        modify("Last Date Modified")
        {
            Caption = 'Last Date Modified';
        }
        modify("Date Filter")
        {
            Caption = 'Date Filter';
        }
        modify("Global Dimension 1 Filter")
        {
            Caption = 'Global Dimension 1 Filter';
        }
        modify("Global Dimension 2 Filter")
        {
            Caption = 'Global Dimension 2 Filter';
        }
        modify(Balance)
        {
            Caption = 'Balance';
        }
        modify("Balance (LCY)")
        {
            Caption = 'Balance ($)';
        }
        modify("Net Change")
        {
            Caption = 'Net Change';
        }
        modify("Net Change (LCY)")
        {
            Caption = 'Net Change ($)';
        }
        modify("Sales (LCY)")
        {
            Caption = 'Sales ($)';
        }
        modify("Profit (LCY)")
        {
            Caption = 'Profit ($)';
        }
        modify("Inv. Discounts (LCY)")
        {
            Caption = 'Inv. Discounts ($)';
        }
        modify("Pmt. Discounts (LCY)")
        {
            Caption = 'Pmt. Discounts ($)';
        }
        modify("Balance Due")
        {
            Caption = 'Balance Due';
        }
        modify("Balance Due (LCY)")
        {
            Caption = 'Balance Due ($)';
        }
        modify(Payments)
        {
            Caption = 'Payments';
        }
        modify("Invoice Amounts")
        {
            Caption = 'Invoice Amounts';
        }
        modify("Cr. Memo Amounts")
        {
            Caption = 'Cr. Memo Amounts';
        }
        modify("Finance Charge Memo Amounts")
        {
            Caption = 'Finance Charge Memo Amounts';
        }
        modify("Payments (LCY)")
        {
            Caption = 'Payments ($)';
        }
        modify("Inv. Amounts (LCY)")
        {
            Caption = 'Inv. Amounts ($)';
        }
        modify("Cr. Memo Amounts (LCY)")
        {
            Caption = 'Cr. Memo Amounts ($)';
        }
        modify("Fin. Charge Memo Amounts (LCY)")
        {
            Caption = 'Fin. Charge Memo Amounts ($)';
        }
        modify("Outstanding Orders")
        {
            Caption = 'Outstanding Orders';
        }
        modify("Shipped Not Invoiced")
        {
            Caption = 'Shipped Not Invoiced';
        }
        modify("Application Method")
        {
            Caption = 'Application Method';
#pragma warning disable AL0600
            OptionCaption = 'Manual,Apply to Oldest';
#pragma warning restore AL0600
        }
        modify("Prices Including VAT")
        {
            Caption = 'Prices Including Tax';
        }
        modify("Location Code")
        {
            Caption = 'Location Code';
        }
        modify("Fax No.")
        {
            Caption = 'Fax No.';
        }
        modify("Telex Answer Back")
        {
            Caption = 'Telex Answer Back';
        }
        modify("VAT Registration No.")
        {
            Caption = 'Tax Registration No.';
        }
        modify("Combine Shipments")
        {
            Caption = 'Combine Shipments';
        }
        modify("Gen. Bus. Posting Group")
        {
            Caption = 'Gen. Bus. Posting Group';
        }
        /* modify(Picture)
        {
            Caption = 'Picture';
        } */
        modify(GLN)
        {
            Caption = 'GLN';
        }
        modify("Post Code")
        {
            Caption = 'ZIP Code';
        }
        modify(County)
        {

            //Unsupported feature: Property Modification (Data type) on "County(Field 92)".

            Caption = 'State';
        }
        modify("Debit Amount")
        {
            Caption = 'Debit Amount';
        }
        modify("Credit Amount")
        {
            Caption = 'Credit Amount';
        }
        modify("Debit Amount (LCY)")
        {
            Caption = 'Debit Amount ($)';
        }
        modify("Credit Amount (LCY)")
        {
            Caption = 'Credit Amount ($)';
        }
        modify("E-Mail")
        {
            Caption = 'Personal Email Address';

        }
        modify("Home Page")
        {
            Caption = 'Home Page';
        }
        modify("Reminder Terms Code")
        {
            Caption = 'Reminder Terms Code';
        }
        modify("Reminder Amounts")
        {
            Caption = 'Reminder Amounts';
        }
        modify("Reminder Amounts (LCY)")
        {
            Caption = 'Reminder Amounts ($)';
        }
        modify("No. Series")
        {
            Caption = 'No. Series';
        }
        modify("Tax Area Code")
        {
            Caption = 'Tax Area Code';
        }
        modify("Tax Liable")
        {
            Caption = 'Tax Liable';
        }
        modify("VAT Bus. Posting Group")
        {
            Caption = 'Tax Bus. Posting Group';
        }
        modify("Currency Filter")
        {
            Caption = 'Currency Filter';
        }
        modify("Outstanding Orders (LCY)")
        {
            Caption = 'Outstanding Orders ($)';
        }
        modify("Shipped Not Invoiced (LCY)")
        {
            Caption = 'Shipped Not Invoiced ($)';
        }
        modify(Reserve)
        {
            Caption = 'Reserve';
#pragma warning disable AL0600
            OptionCaption = 'Never,Optional,Always';
#pragma warning restore AL0600
        }
        modify("Block Payment Tolerance")
        {
            Caption = 'Block Payment Tolerance';
        }
        modify("Pmt. Disc. Tolerance (LCY)")
        {
            Caption = 'Pmt. Disc. Tolerance ($)';
        }
        modify("Pmt. Tolerance (LCY)")
        {
            Caption = 'Pmt. Tolerance ($)';
        }
        modify("IC Partner Code")
        {
            Caption = 'IC Partner Code';
        }
        modify(Refunds)
        {
            Caption = 'Refunds';
        }
        modify("Refunds (LCY)")
        {
            Caption = 'Refunds ($)';
        }
        modify("Other Amounts")
        {
            Caption = 'Other Amounts';
        }
        modify("Other Amounts (LCY)")
        {
            Caption = 'Other Amounts ($)';
        }
        modify("Prepayment %")
        {
            Caption = 'Prepayment %';
        }
        modify("Outstanding Invoices (LCY)")
        {
            Caption = 'Outstanding Invoices ($)';
        }
        modify("Outstanding Invoices")
        {
            Caption = 'Outstanding Invoices';
        }
        modify("Bill-to No. Of Archived Doc.")
        {
            Caption = 'No. Of Archived Doc.';
        }
        modify("Sell-to No. Of Archived Doc.")
        {
            Caption = 'Sell-to No. Of Archived Doc.';
        }
        modify("Partner Type")
        {
            Caption = 'Partner Type';
#pragma warning disable AL0600
            OptionCaption = ' ,Company,Person';
#pragma warning restore AL0600
        }
        modify(Image)
        {

            Caption = 'Image';
        }
        modify("Privacy Blocked")
        {
            Caption = 'Privacy Blocked';
        }
        modify("Preferred Bank Account Code")
        {
            Caption = 'Preferred Bank Account Code';
        }
        modify("Cash Flow Payment Terms Code")
        {
            Caption = 'Cash Flow Payment Terms Code';
        }
        modify("Primary Contact No.")
        {
            Caption = 'Primary Contact No.';
        }
        modify("Contact Type")
        {
            Caption = 'Contact Type';
#pragma warning disable AL0600
            OptionCaption = 'Company,Person';
#pragma warning restore AL0600
        }
        modify("Responsibility Center")
        {
            Caption = 'Responsibility Center';
        }
        modify("Shipping Advice")
        {
            Caption = 'Shipping Advice';
#pragma warning disable AL0600
            OptionCaption = 'Partial,Complete';
#pragma warning restore AL0600
        }
        modify("Shipping Time")
        {
            Caption = 'Shipping Time';
        }
        modify("Shipping Agent Service Code")
        {
            Caption = 'Shipping Agent Service Code';
        }
        modify("Service Zone Code")
        {
            Caption = 'Service Zone Code';
        }
        modify("Contract Gain/Loss Amount")
        {
            Caption = 'Contract Gain/Loss Amount';
        }
        modify("Ship-to Filter")
        {
            Caption = 'Ship-to Filter';
        }
        modify("Outstanding Serv. Orders (LCY)")
        {
            Caption = 'Outstanding Serv. Orders ($)';
        }
        modify("Serv Shipped Not Invoiced(LCY)")
        {
            Caption = 'Serv Shipped Not Invoiced($)';
        }
        modify("Outstanding Serv.Invoices(LCY)")
        {
            Caption = 'Outstanding Serv.Invoices($)';
        }
        modify("Allow Line Disc.")
        {
            Caption = 'Allow Line Disc.';
        }
        modify("No. of Quotes")
        {
            Caption = 'No. of Quotes';
        }
        modify("No. of Blanket Orders")
        {
            Caption = 'No. of Blanket Orders';
        }
        modify("No. of Orders")
        {
            Caption = 'No. of Orders';
        }
        modify("No. of Invoices")
        {
            Caption = 'No. of Invoices';
        }
        modify("No. of Return Orders")
        {
            Caption = 'No. of Return Orders';
        }
        modify("No. of Credit Memos")
        {
            Caption = 'No. of Credit Memos';
        }
        modify("No. of Pstd. Shipments")
        {
            Caption = 'No. of Pstd. Shipments';
        }
        modify("No. of Pstd. Invoices")
        {
            Caption = 'No. of Pstd. Invoices';
        }
        modify("No. of Pstd. Return Receipts")
        {
            Caption = 'No. of Pstd. Return Receipts';
        }
        modify("No. of Pstd. Credit Memos")
        {
            Caption = 'No. of Pstd. Credit Memos';
        }
        modify("No. of Ship-to Addresses")
        {
            Caption = 'No. of Ship-to Addresses';
        }
        modify("Bill-To No. of Quotes")
        {
            Caption = 'Bill-To No. of Quotes';
        }
        modify("Bill-To No. of Blanket Orders")
        {
            Caption = 'Bill-To No. of Blanket Orders';
        }
        modify("Bill-To No. of Orders")
        {
            Caption = 'Bill-To No. of Orders';
        }
        modify("Bill-To No. of Invoices")
        {
            Caption = 'Bill-To No. of Invoices';
        }
        modify("Bill-To No. of Return Orders")
        {
            Caption = 'Bill-To No. of Return Orders';
        }
        modify("Bill-To No. of Credit Memos")
        {
            Caption = 'Bill-To No. of Credit Memos';
        }
        modify("Bill-To No. of Pstd. Shipments")
        {
            Caption = 'Bill-To No. of Pstd. Shipments';
        }
        modify("Bill-To No. of Pstd. Invoices")
        {
            Caption = 'Bill-To No. of Pstd. Invoices';
        }
        modify("Bill-To No. of Pstd. Return R.")
        {
            Caption = 'Bill-To No. of Pstd. Return R.';
        }
        modify("Bill-To No. of Pstd. Cr. Memos")
        {
            Caption = 'Bill-To No. of Pstd. Cr. Memos';
        }
        modify("Base Calendar Code")
        {
            Caption = 'Base Calendar Code';
        }
        /*  modify("Copy Sell-to Addr. to Qte From")
         {
             Caption = 'Copy Sell-to Addr. to Qte From';
             OptionCaption = 'Company,Person';
         } */
        modify("Validate EU Vat Reg. No.")
        {
            Caption = 'Validate EU Tax Reg. No.';
        }
        /*  modify(Id)
         {
             Caption = 'Id';
         } */
        modify("Currency Id")
        {
            Caption = 'Currency Id';
        }
        modify("Payment Terms Id")
        {
            Caption = 'Payment Terms Id';
        }
        modify("Shipment Method Id")
        {
            Caption = 'Shipment Method Id';
        }
        modify("Payment Method Id")
        {
            Caption = 'Payment Method Id';
        }
        modify("Tax Area ID")
        {
            Caption = 'Tax Area ID';
        }
        // modify("Tax Area Display Name")
        // {
        //     Caption = 'Tax Area Display Name';
        // }
        modify("Contact ID")
        {
            Caption = 'Contact ID';
        }
        modify("Contact Graph Id")
        {
            Caption = 'Contact Graph Id';
        }
        field(50050; "Balance (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("CAT-Det. Students Cafe Ledgers".Amount WHERE("Customer No." = FIELD("No.")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50051; "Debit Amount (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("CAT-Det. Students Cafe Ledgers"."Debit Amount" WHERE("Customer No." = FIELD("No.")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50052; "Credit Amount (Cafe)"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = Sum("CAT-Det. Students Cafe Ledgers"."Credit Amount" WHERE("Customer No." = FIELD("No.")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60171; "Has an Irregularity"; Boolean)
        {
            CalcFormula = Exist("ACA-Irregularities Register" WHERE("Student No." = FIELD("No."),
                                                                     "Irregularity Type" = FILTER("Exam Irregularity")));
            FieldClass = FlowField;
        }
        field(63000; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Male,Female;
        }
        field(63001; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63002; Age; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63003; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Single,Married,Divorced,Deceased;
        }
        field(63004; "Blood Group"; Text[2])
        {
            DataClassification = ToBeClassified;
        }
        field(63005; Weight; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(787665; "Department"; Code[60])
        {
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('DEPARTMENT'));
            DataClassification = ToBeClassified; // Set appropriate data classification based on the data
        }
        field(63006; Height; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63007; Religion; Code[20])
        {
            Caption = 'Religions';
            DataClassification = ToBeClassified;
            //TableRelation = "GEN-Religion";
        }
        field(63008; Citizenship; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63009; "Payments By"; Code[70])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Payment By".Code;
        }
        field(63010; "Student Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Student Types".Code;
        }
        field(63011; "ID No"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Cust.RESET;
                Cust.SETRANGE(Cust."ID No", "ID No");
                IF Cust.FIND('-') THEN
                    ERROR('Passport/ID No. exists.');
            end;
        }
        field(63012; "Date Registered"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63013; "Membership No"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63014; "Customer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Customer,Student,Hotel';
            OptionMembers = Customer,Student,Hotel;
        }
        field(63015; "Birth Cert"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Cust.RESET;
                Cust.SETRANGE(Cust."Birth Cert", "Birth Cert");
                IF Cust.FIND('-') THEN
                    ERROR('Birth Cert/KNEC No. exists.');
            end;
        }
        field(63016; "UNISA No"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63018; "Old Student Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63019; "Name 3"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63020; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Registration,Current,Alluminae,Dropped Out,Alumnae,Demoted,Other,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Completed not graduated,Graduated no Certificates,Graduated with Certificate,Did Not Report,Absconded,Resit,Halt';
            OptionMembers = Registration,Current,Alluminae,"Dropped Out",Alumnae,Demoted,Other,Deffered,Suspended,Expulsion,Discontinued,Deferred,Deceased,Transferred,Disciplinary,Unknown,Graduand,"Graduated no Certificates","Graduated with Certificate","Did Not Report",Absconded,Resit,Halt;


            trigger OnValidate()
            var
                usersetup: Record "User Setup";
                AllowAccessSettings: boolean;
                Nopermission: Label 'You Cannot Change Status!!';
            begin
                AllowAccessSettings := true;
                if usersetup.get(UserId) then
                    if (usersetup."Can change Status") then begin
                        AllowAccessSettings := usersetup."Can change Status";
                        exit
                    end;
                Error(Nopermission);
            end;

        }
        field(63021; "Total Billed"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Student No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63022; "Library Code"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63024; "KNEC No"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63025; "Passport No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(63026; "Total Paid"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges"."Amount Paid" WHERE("Student No." = FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63030; "No. Of Receipts"; Integer)
        {
            CalcFormula = Count("ACA-Receipt" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63034; "Confirmed Ok"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "User ID" := USERID;
            end;
        }
        field(63035; "User ID"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63037; "No Of Charges"; Integer)
        {
            CalcFormula = Count("ACA-Std Charges" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63038; "Library Membership"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'DIP IT,BSC IT,IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,TEACHING STAFF,DIRECTORS,ADMIN STAFF,BR MATHS,IT,PACKAGES,DCEDHM';
            OptionMembers = "DIP IT","BSC IT",IMIS,KATC,CPACPS,ACCA,ABE,UNISA,BCOM,"TEACHING STAFF",DIRECTORS,"ADMIN STAFF","BR MATHS",IT,PACKAGES,DCEDHM;
        }
        field(63039; libsecurity; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63040; "Can Use Library"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'USED BY LIBRARY TO CHECK WETHER STUDENT EXISTS IN LIB SYSTEM - 12TH JUNE 2008 - TONY';

            trigger OnValidate()
            begin
                TESTFIELD("Library Category");
                "Library Security" := 1;
                MODIFY;
            end;
        }
        field(63041; "Lib Membership"; Text[1])
        {
            DataClassification = ToBeClassified;
            Description = 'STORES THE STUDENTS LATEST LIBRARY MEMBSERSHIP CATEGORY - 12TH JUNE 2008 - TONY';
        }
        field(63042; "No Of Reversals"; Integer)
        {
            CalcFormula = Count("Cust. Ledger Entry" WHERE("Customer No." = FIELD("No."),
                                                            Reversed = CONST(True)));
            FieldClass = FlowField;
        }
        field(63043; "Document No. Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Cust. Ledger Entry"."Document No.";
        }
        field(63046; "Semester Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Semester".Code;
        }
        field(63047; "Staff No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63048; "Programme Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(63050; "Application No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Enquiry Header"."Enquiry No." WHERE(Status = CONST(Eligible));

            trigger OnValidate()
            begin
                Enrollment.RESET;
                IF Enrollment.GET("Application No.") THEN BEGIN
                    Rec.Name := Enrollment."Name(Surname First)";
                    Rec."Search Name" := UPPERCASE(Rec.Name);
                    Rec.Address := Enrollment."Permanent Home Address";
                    Rec."Address 2" := Rec.Address;
                    Rec."Phone No." := Enrollment."Home Telephone No.";
                    Rec."Telex No." := Enrollment."Fax Number";
                    Rec."E-Mail" := Enrollment."Email Address";
                    Rec.Gender := Enrollment.Gender;
                    Rec."Date Of Birth" := Enrollment."Date of Birth";
                    Rec."Date Registered" := TODAY;
                    Rec."Customer Type" := Rec."Customer Type"::Student;
                    Rec."Student Type" := FORMAT(Enrollment."Student Type");
                    Rec."ID No" := Enrollment."Passport/National ID Number";
                    "Customer Posting Group" := 'STUDENTS';
                    VALIDATE("Customer Posting Group");


                    //insert the course registration details
                    CourseRegistration.RESET;
                    CourseRegistration.INIT;
                    CourseRegistration."Reg. Transacton ID" := '';
                    CourseRegistration.VALIDATE(CourseRegistration."Reg. Transacton ID");
                    CourseRegistration."Student No." := Rec."No.";
                    CourseRegistration.Programmes := Enrollment.Programmes;
                    CourseRegistration.Semester := Enrollment.Semester;
                    CourseRegistration.Stage := Enrollment."Programme Stage";
                    //CourseRegistration."Student Type" := Enrollment."Student Type";
                    CourseRegistration."Registration Date" := TODAY;
                    //CourseRegistration."Settlement Type":='FULL PAYMENT';
                    //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                    CourseRegistration.INSERT;

                    CourseRegistration.RESET;
                    CourseRegistration.SETRANGE(CourseRegistration."Student No.", "No.");
                    IF CourseRegistration.FIND('+') THEN BEGIN
                        CourseRegistration."Registration Date" := TODAY;
                        CourseRegistration.VALIDATE(CourseRegistration."Registration Date");
                        //CourseRegistration."Settlement Type":='FULL PAYMENT';
                        //CourseRegistration.VALIDATE(CourseRegistration."Settlement Type");
                        CourseRegistration.MODIFY;

                    END;




                    //insert the details related to the next of kin of the student into the database
                    EnrollmentNextofKin.RESET;
                    EnrollmentNextofKin.SETRANGE(EnrollmentNextofKin."Enquiry No", Enrollment."Enquiry No.");
                    IF EnrollmentNextofKin.FIND('-') THEN BEGIN
                        REPEAT
                            StudentKin.RESET;
                            StudentKin.INIT;
                            StudentKin."Student No" := Rec."No.";
                            StudentKin.Relationship := EnrollmentNextofKin.Relationship;
                            StudentKin.Name := EnrollmentNextofKin.SurName;
                            StudentKin."Other Names" := EnrollmentNextofKin."Other Names";
                            StudentKin."ID No/Passport No" := EnrollmentNextofKin."ID No/Passport No";
                            StudentKin."Date Of Birth" := EnrollmentNextofKin."Date Of Birth";
                            StudentKin.Occupation := EnrollmentNextofKin.Occupation;
                            StudentKin."Office Tel No" := EnrollmentNextofKin."Office Tel No";
                            StudentKin."Home Tel No" := EnrollmentNextofKin."Home Tel No";
                            StudentKin.Remarks := EnrollmentNextofKin.Remarks;
                            StudentKin.INSERT;
                        UNTIL EnrollmentNextofKin.NEXT = 0;
                    END;
                    //insert the details in relation to the guardian/sponsor into the database in relation to the current student
                    EnrollmentGuardian.RESET;
                    EnrollmentGuardian.SETRANGE(EnrollmentGuardian."Enquiry No.", Enrollment."Enquiry No.");
                    IF EnrollmentGuardian.FIND('-') THEN BEGIN
                        REPEAT
                            StudentGuardian.RESET;
                            StudentGuardian.INIT;
                            StudentGuardian."Student No." := Rec."No.";
                            StudentGuardian.Names := EnrollmentGuardian.SurName + ' ' + EnrollmentGuardian."Other Names";
                            StudentGuardian.Address := EnrollmentGuardian.Address;
                            StudentGuardian."Telephone No" := EnrollmentGuardian."Office Tel No";
                            StudentGuardian.INSERT;
                        UNTIL EnrollmentGuardian.NEXT = 0;
                    END;
                    //insert the details in relation to the student history as detailed in the application
                    EnrollmentEducationHistory.RESET;
                    EnrollmentEducationHistory.SETRANGE(EnrollmentEducationHistory."Enquiry No.", Enrollment."Enquiry No.");
                    IF EnrollmentEducationHistory.FIND('-') THEN BEGIN
                        REPEAT
                            EducationHistory.RESET;
                            EducationHistory.INIT;
                            EducationHistory."Student No." := Rec."No.";
                            EducationHistory.From := EnrollmentEducationHistory.From;
                            EducationHistory."To" := EnrollmentEducationHistory."To";
                            EducationHistory.Qualifications := EnrollmentEducationHistory.Qualifications;
                            EducationHistory.Instituition := EnrollmentEducationHistory.Instituition;
                            EducationHistory.Remarks := EnrollmentEducationHistory.Remarks;
                            EducationHistory."Aggregate Result/Award" := EnrollmentEducationHistory."Aggregate Result/Award";
                            EducationHistory.INSERT;
                        UNTIL EnrollmentEducationHistory.NEXT = 0;
                    END;
                    //update the status of the application
                    Enrollment."Registration No" := Rec."No.";
                    Enrollment.Status := Enrollment.Status::Admitted;
                    Enrollment.MODIFY;
                END;
            end;
        }
        field(63051; "Accredited Centre no."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63052; "Unbilled Charged"; Integer)
        {
            CalcFormula = Count("ACA-Std Charges" WHERE("Student No." = FIELD("No."),
                                                         Recognized = CONST(false)));
            FieldClass = FlowField;
        }
        field(63055; Adults; Integer)
        {
            DataClassification = ToBeClassified;
            InitValue = 1;
        }
        field(63056; "Vehicle No."; Code[5])
        {
            DataClassification = ToBeClassified;
        }
        field(63057; "Children Under 12"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63058; "Group/Company"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63059; "Departure Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63060; "Arrival Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63061; Nationality; Text[20])
        {
            DataClassification = ToBeClassified;
            //InitValue = 'KENYAN';
            TableRelation = "ACA-Academics Central Setups"."Title Code" WHERE(Category = FILTER(Nationality));
        }
        field(63062; "Room no"; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(63063; "Room Type"; Code[6])
        {
            DataClassification = ToBeClassified;
        }
        field(63064; "Receipt No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63065; Rate; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63066; Cashier; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63067; Deposit; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(63068; "Payment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63069; Remarks; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63071; Singles; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63073; Doubles; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63074; Triples; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63075; "Taken By"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63076; "Checked By"; Text[1])
        {
            DataClassification = ToBeClassified;
        }
        field(63078; "Check Out Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63079; "Check In Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(63080; "HTL Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,,Reserved,Current,Old;
        }
        field(63081; "HELB No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63082; "Deferement Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(63083; "Status Change Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63084; "Revenue Cash Account"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"."No." WHERE("Bank Acc. Posting Group" = CONST('CASH'));
        }
        field(63085; Password; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(63086; "Gown 1"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63087; "Gown 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63088; "Gown 3"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63089; "Date Issued"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63090; "Gown Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Loaned,Returned';
            OptionMembers = " ",Loaned,Returned;

            trigger OnValidate()
            begin
                IF "Gown Status" = "Gown Status"::Loaned THEN
                    "Date Issued" := TODAY;

                IF "Gown Status" = "Gown Status"::Returned THEN
                    "Date Returned" := TODAY;
            end;
        }
        field(63091; "Date Returned"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63092; "Certificate Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Pending,Collected';
            OptionMembers = " ",Pending,Collected;

            trigger OnValidate()
            begin
                IF "Certificate Status" = "Certificate Status"::Collected THEN
                    "Date Collected" := TODAY;
            end;
        }
        field(63093; "Date Collected"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63094; Confirmed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63095; "Confirmed Remarks"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(63096; "Special Requrements"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63097; "Certificate No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63098; "No. Of Reg"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63099; "No Of Creidts"; Integer)
        {
            CalcFormula = Count("Detailed Cust. Ledg. Entry" WHERE("Customer No." = FIELD("No."),
                                                                    "Entry Type" = CONST("Initial Entry"),
                                                                    "Credit Amount (LCY)" = FILTER(> 0)));
            FieldClass = FlowField;
        }
        field(63100; District; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Applic. Setup County".Code;

            trigger OnValidate()
            begin
                districtrec.RESET;
                Districtname := '';
                districtrec.SETRANGE(districtrec.Code, District);
                IF districtrec.FIND('-') THEN
                    Districtname := districtrec.Description;
            end;
        }
        field(63101; "Student Programme"; Code[20])
        {
            CalcFormula = Max("ACA-Course Registration".Programmes WHERE("Student No." = FIELD("No.")));
            Description = 'flowfield to look up program table';
            FieldClass = FlowField;
            TableRelation = "ACA-Programme".Code;
        }
        field(63102; "Programme Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Programme".Code;
        }
        field(63103; "Transfer to No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63104; "Transfer to"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Transfer to';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(63106; "Stage Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(63107; "Settlement Type Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Settlement Type".Code;
        }
        field(63108; "Current Programme"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Auto populated on Billing';
        }
        field(63109; "Registered PartTime"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FILTER('*04???*'),
                                                                 Programmes = FIELD("Student Programme")));
            FieldClass = FlowField;
        }
        field(63110; "Registered FullTime"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FILTER('<*04???*'),
                                                                 Programmes = FIELD("Student Programme")));
            FieldClass = FlowField;
        }
        field(63111; "Total Registered"; Integer)
        {
            FieldClass = Normal;
        }
        field(63112; "Paid PartTime"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63113; "Hostel Black Listed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63114; "Black Listed Reason"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63115; "Black Listed By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63116; "Audit Issue"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63117; "Not Billed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63118; "New Stud"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63119; "Programme Category Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = ',Diploma,Undergraduate,Postgraduate,Course List';
            OptionMembers = ,Diploma,Undergraduate,Postgraduate,"Course List";
        }
        field(63120; sms_Password; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(63121; "BroadCast Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            //TableRelation = GEN-sms_BroadCast.Code;
        }
        field(63122; "In Current Sem"; Integer)
        {
            CalcFormula = Count("ACA-Course Registration" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63123; "Current Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63124; "Current Stage"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration".Stage WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63125; "Intake Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Intake".Code;
        }
        field(63126; "Exam Period Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Exam Periods".Code;
        }
        field(63127; "Lock Online Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63128; "PIN No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63129; "Allow Reg. With Balance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63130; "Allowed Reg. By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63131; "Allowed Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63132; "Current Program"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63133; "Current Semester"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63134; "ID Card Expiry Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63135; Tribe; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = Tribes."Tribe Code";
        }
        field(63136; "Barcode Picture"; BLOB)
        {
            Caption = 'Picture';
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(63137; "Graduation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63138; "Class Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Course Classes".Code;
        }
        field(63139; "Course Details"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63140; "Sponsor Name"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63141; School; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER('SCHOOL'));
        }
        field(63142; "Study Mode"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full Time,Part Time,Weekend,ODL,School Based,Evening';
            OptionMembers = " ","Full Time","Part Time",Weekend,ODL,"School Based",Evening;
        }
        field(63143; "Course Duration"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63144; "Admission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63145; "Hostel Allocated"; Boolean)
        {
            CalcFormula = Exist("ACA-Hostel Ledger" WHERE("Student No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63146; "Hostel No."; Code[20])
        {
            CalcFormula = Lookup("ACA-Hostel Ledger"."Hostel No" WHERE("Student No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63147; "Room Code"; Code[20])
        {
            CalcFormula = Lookup("ACA-Hostel Ledger"."Room No" WHERE("Student No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63148; "Space Booked"; Code[20])
        {
            CalcFormula = Lookup("ACA-Hostel Ledger"."Space No" WHERE("Student No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63149; "Academic Year"; Code[20])
        {
            CalcFormula = Lookup("ACA-Hostel Ledger"."Academic Year" WHERE("Student No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63150; Semester; Code[20])
        {
            CalcFormula = Lookup("ACA-Hostel Ledger".Semester WHERE("Student No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63151; "Library Security"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63152; "Library Username"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63153; "Library Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Library Codes"."Lib Code";

            trigger OnValidate()
            begin
                LibCode.GET("Library Category");
                "Library Expiry Date" := TODAY + LibCode."Expiry Duration";
            end;
        }
        field(63154; "Library Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63155; "Old Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63156; "Sponsor Address"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63157; "Sponsor Town"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63158; "Sponsor Phone"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63159; "Changed Password"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63160; "Catering Amount"; Decimal)
        {
            CalcFormula = Sum("CAT-Catering Prepayment Ledger".Amount WHERE("Customer No" = FIELD("No."),
                                                                             Date = FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(63161; "Clearance Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'open,Active,Cleared';
            OptionMembers = open,Active,Cleared;
        }
        field(63162; "Clearance Initiated by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63163; "Clearance Initiated Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63164; "Clearance Initiated Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(63165; "Clearance Semester"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Semesters".Code;
        }
        field(63166; "Clearance Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Academic Year".Code;
        }
        field(63167; "Intake Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63168; "Programme End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(63169; "Applied for Clearance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63170; "Clearance Reason"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Graduation,Suspension,Transfer';
            OptionMembers = " ",Graduation,Suspension,Transfer;
        }
#pragma warning disable AL0717
        field(63171; "Refund on PV"; Decimal)
#pragma warning restore AL0717
        {
            //CalcFormula = Sum("FIN-Payment Line"."Net Amount" WHERE ("Account No."=FIELD("No."),
            //  Posted=CONST(No),
            //  "Payment Status"=CONST(Approved)));
            FieldClass = FlowField;
        }
        field(63175; "Library Gender"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63176; "Library Branch"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63177; "Current Faculty"; Code[20])
        {
            CalcFormula = Lookup("ACA-Programme"."School Code" WHERE(Code = FIELD("Current Programme")));
            FieldClass = FlowField;
        }
        field(63178; "Charges Amount"; Decimal)
        {
            CalcFormula = Sum("ACA-Std Charges".Amount WHERE("Student No." = FIELD("No."),
                                                              Semester = FIELD("Semester Filter"),
                                                              Code = FIELD("Charge Filter")));
            FieldClass = FlowField;
        }
        field(63179; "Charge Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "ACA-Charge".Code;
        }
        field(63180; Programme; Text[200])
        {
            CalcFormula = Lookup("ACA-Programme".Description WHERE(Code = FIELD("Current Programme")));
            FieldClass = FlowField;
        }
        field(63181; "Student Balance"; Decimal)
        {
            CalcFormula = Sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" WHERE("Customer No." = FIELD("No."),
                                                                                 "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                                 "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                                 "Currency Code" = FIELD("Currency Filter")));
            FieldClass = FlowField;
        }
        field(63182; "Comp No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63183; "Spouce Name"; Text[70])
        {
            DataClassification = ToBeClassified;
        }
        field(63184; "Spouse Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63185; "Spouse Phone"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63186; Countings; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(63187; "Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63188; "Barcode/QR Code"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(63189; "Disability Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Yes,No';
            OptionMembers = ,"Yes",No;
        }
        field(63190; "Updated Profile"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63191; "Disability Description"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63192; "Email Password"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63193; "University Email"; Text[80])
        {
            DataClassification = ToBeClassified;
            Caption = 'CUEA Email';
        }
        field(63194; "Campus Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(63195; "Senate Classification Based on"; Option)
        {
            CalcFormula = Lookup("Dimension Value"."Senate Classification Based on" WHERE(Code = FIELD("Global Dimension 1 Code")));
            FieldClass = FlowField;
            OptionCaption = ' ,Year of Study,Academic Year';
            OptionMembers = " ","Year of Study","Academic Year";
        }
        /* field(63196; "Programme Category"; Option)
        {
            CalcFormula = Lookup("ACA-Course Registration"."Programme Category" WHERE("Student No." = FIELD("No.")));
            FieldClass = FlowField;
            OptionCaption = ',Certificate ,Diploma,Undergraduate,Postgraduate,Professional,Course List';
            OptionMembers = ,"Certificate ",Diploma,Undergraduate,Postgraduate,Professional,"Course List";
        } */
        field(63197; "County of Origin"; Text[50])
        {

            FieldClass = FlowField;
            CalcFormula = lookup("ACA-Academics Central Setups".Description where("Title Code" = field(County)));
        }
        field(63198; "Tagged as Graduating"; Boolean)
        {
            CalcFormula = Lookup("ACA-Classification Students".Graduating WHERE("Student Number" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(63199; "Graduating Academic Year"; Code[20])
        {
            CalcFormula = Lookup("ACA-Classification Students"."Graduation Academic Year" WHERE("Student Number" = FIELD("No."),
                                                                                                 Graduating = FILTER(true)));
            FieldClass = FlowField;
        }
        field(63200; "Cumm. Failed Courses"; Integer)
        {
            CalcFormula = Count("ACA-Student Units" WHERE("Passed Unit" = FILTER(false),
                                                           "Reg. Reversed" = FILTER(false),
                                                           "Student No." = FIELD("No."),
                                                           "EXAMs Marks Exists" = FILTER(true),
                                                           "Pass Exists" = FILTER(false)));
            FieldClass = FlowField;
        }
        field(63201; "First Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(63202; "Middle Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(63203; "Last Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(63204; Ethnicity; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63205; "Denomiation"; Enum Denominations)
        {
            DataClassification = ToBeClassified;
        }
        field(63206; "Allien Number"; Code[30])
        {
            DataClassification = ToBeClassified;

        }
        field(63207; Congregation; Option)
        {
            //DataClassification = ToBeClassified;
            OptionMembers = Lay,Brothers,Sisters,"Diocesan-Priest",Seminarian,Novice,Deacon;
        }
        field(63208; "High Sch. Index Number"; Code[20])
        {
            Caption = 'High School Index No.';

        }
        // field(62309; "Disability Type"; enum "Disability Type")
        // {

        // }
        field(62310; "Disability No."; Code[20])
        {
            Caption = 'Disability Numbers';
        }
        field(62311; "Alternate Mobile"; Code[20])
        {
            Caption = 'Alternate Mobile';
        }
        field(62312; bioDataVerified; Option)
        {
            OptionMembers = " ",Yes,No;
            Caption = 'Student Bio-Data verified';
        }
        field(62313; stubioDatVER; Code[20])
        {
            Caption = 'Student BioData Verifier Staff ID';
            TableRelation = "HRM-Employee (D)";
        }
        field(62314; "Fee Cleared"; Boolean)
        {

        }
        field(62315; "Disability Type"; Option)
        {
            OptionMembers = None,"Sensory Impairement","Mental Impairement","Visiual Impairement","Hearing Impairement","Learning Impairement","Physical Impairement",Other;
        }
        field(62316; "Updated Nationality"; Boolean)
        {

        }
        field(62317; "countryName"; text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("ACA-Academics Central Setups".Description where("Title Code" = field(Nationality)));
        }
        field(62318; "Password Reset OTP"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Password Reset OTP';
        }

    }
    keys
    {

        //Unsupported feature: Deletion (KeyCollection) on ""Primary Contact No."(Key)".

        //key(Key1;"Salesperson Code")
        // {
        // }
    }


    var
        Text10000: Label '%1 is not a valid RFC No.';
        Text10001: Label '%1 is not a valid CURP No.';
        Text10002: Label 'The RFC number %1 is used by another company.';

    var
        RecType: Option " ",GL,Cust,Item,Supp,FA,Emp,Sal,CourseReg,prTrans,EmpTrans;
        Cust: Record 18;
        GenSetUp: Record 61534;
        EducationHistory: Record 61529;
        EnrollmentEducationHistory: Record 61355;
        StudentGuardian: Record 61530;
        EnrollmentGuardian: Record 61353;
        StudentKin: Record 61528;
        EnrollmentNextofKin: Record 61352;
        CourseRegistration: Record 61532;
        Enrollment: Record 61348;
        PictureExists: Boolean;
        StudentRec: Record 18;
        districtrec: Record 61365;
        Districtname: Text[50];
        LibCode: Record 61563;
    // ValidateUser: Codeunit "61105";
}

