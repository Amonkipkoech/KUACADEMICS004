// tableextension 70002 "User Setups" extends "User Setup"
// {
//     fields
//     {
//         //modify("User ID")
//         //{
//         // TableRelation = IF ("Is Employee" = FILTER(false)) User."User Name"
//         // ELSE
//         // IF ("Is Employee" = FILTER(Yes)) "HRM-Employee C"."No.";

//         //Unsupported feature: Property Modification (ValidateTableRelation) on ""User ID"(Field 1)".

//         // }
//         field(50000; Leave; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50009; tetst; Code[20])
//         {
//             CaptionClass = '1,2,2';
//             Caption = 'Shortcut Dimension 2 Code';
//             DataClassification = ToBeClassified;
//             Description = 'Stores the reference of the second global dimension in the database';
//             NotBlank = false;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
//         }
//         field(50018; "Post Bank Rec"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50023; "Can Stop Reg."; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50027; "Cash Advance Staff Account"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Customer."No.";
//         }
//         field(50030; "ReOpen/Release"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = " ",ReOpen,Release;
//         }
//         field(50031; "Location Code"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Location.Code;
//         }
//         field(50036; "Approval Title"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50037; "Employee No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "HRM-Employee C"."No.";
//         }
//         field(50038; UserName; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50039; Approvername; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50040; Approvermail; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50041; "Staff No"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('IMPREST'));

//             trigger OnValidate()
//             begin
//                 /*IF Staff.GET("Staff No")THEN BEGIN
//                 UserName:=Staff."First Name"+' '+Staff."Middle Name"+' '+Staff."Last Name";
//                 "E-Mail":=Staff."Company E-Mail";
//                 "Global Dimension 1 Code":=Staff."Department Code";
//                 "Job Tittle":=Staff."Job Title";
//                 END*/

//             end;
//         }
//         field(50042; "Job Tittle"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50043; Department; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER(= 'DEPARTMENT'));
//         }
//         field(50044; "Campus Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FILTER(= 'CAMPUS'));
//         }
//         field(50045; Lecturer; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50100; "Edit Posted Dimensions"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50110; "Journal Template Name"; Code[10])
//         {
//             Caption = 'Journal Template Name';
//             DataClassification = ToBeClassified;
//             TableRelation = "Gen. Journal Template";
//         }
//         field(50111; "Journal Batch Name"; Code[10])
//         {
//             Caption = 'Journal Batch Name';
//             DataClassification = ToBeClassified;
//             TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
//         }
//         field(60000; "Global Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,1,2';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
//         }
//         field(60001; "Responsibility Center"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60002; "Global Dimension 1 Code"; Code[20])
//         {
//             CaptionClass = '1,1,1';
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
//         }
//         field(60003; "Unlimited PV Amount Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60004; "PV Amount Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60005; "Unlimited PettyAmount Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60006; "Petty C Amount Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60007; "Unlimited Imprest Amt Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60008; "Imprest Amount Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60009; "Unlimited Store RqAmt Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60010; "Store Req. Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60011; "Shortcut Dimension 2 Code"; Code[20])
//         {
//             CaptionClass = '1,2,2';
//             Caption = 'Shortcut Dimension 2 Code';
//             DataClassification = ToBeClassified;
//             Description = 'Stores the reference of the second global dimension in the database';
//             NotBlank = false;
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
//         }
//         field(60012; "Shortcut Dimension 3 Code"; Code[20])
//         {
//             CaptionClass = '1,2,3';
//             Caption = 'Shortcut Dimension 3 Code';
//             DataClassification = ToBeClassified;
//             Description = 'Stores the reference of the Third global dimension in the database';
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
//         }
//         field(60013; "Shortcut Dimension 4 Code"; Code[20])
//         {
//             CaptionClass = '1,2,4';
//             Caption = 'Shortcut Dimension 4 Code';
//             DataClassification = ToBeClassified;
//             Description = 'Stores the reference of the Third global dimension in the database';
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
//         }
//         field(60014; "Unlimited ImprestSurr Amt Appr"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60015; "ImprestSurr Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60016; "Unlimited Interbank Amt Appr"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60017; "Interbank Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60018; "Staff Travel Account"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Customer."No.";
//         }
//         field(60019; "Post JVs"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60020; "Post Bank Recs"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60021; "Unlimited Receipt Amt Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60022; "Receipt Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60023; "Unlimited Claim Amt Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60024; "Claim Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60025; "Unlimited Advance Amt Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60026; "Advance Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60027; "Unlimited AdvSurr Amt Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60028; "AdvSurr Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60029; "Other Advance Staff Account"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Customer."No.";
//         }
//         field(60030; "Unlimited Grant Amt Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60031; "Grant Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60032; "Unlimited GrantSurr Approval"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60033; "GrantSurr Amt Approval Limit"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60034; "User Signature"; BLOB)
//         {
//             DataClassification = ToBeClassified;
//             SubType = Bitmap;
//         }
//         field(60035; "Post Staff Grants"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60036; "ReValidate LPOs"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//             Description = 'Can ReOpen Expired LPOs';
//         }
//         field(60037; "Procurement Officer"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60038; "Compliance/Grants"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60039; "Payroll Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60040; test; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60041; "Archiving User"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "User Setup"."User ID";
//         }
//         field(60042; "Allow Transaction Reversal"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60043; "Reverse Hostel Allocations"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60044; "Perform Hostel Transfers"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60045; "Perform Hostel Switching"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60046; "Imprest Account"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Customer."No." WHERE("Customer Posting Group" = FILTER('IMPREST'));
//         }
//         field(60047; "Break"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60048; "Create GL"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60049; "Create Customer"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60050; "Create Supplier"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60051; "Create Items"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60052; "Create FA"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60053; "Create Employee"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60054; "Create Salary"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60055; "Create Course_Reg"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60056; "Create PR Transactions"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60057; "Create Emp. Transactions"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60058; "Approve Payroll Closure"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60059; "Edit Farmer Central Setup"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60060; "Can Post Cust. Deposits"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60061; "Can Post Customer Refund"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60062; "Phone No2."; Text[30])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60063; "Use Two Factor Authentication"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60064; "Can Reverse Sales"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60065; "Is Employee"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }

//         field(60066; "Initiate Results Cancellation"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60067; "Approve Results Cancellation"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60068; "Revoke Results Cancellation"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60069; "Can Archive Students"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60070; "Can Edit Semester"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60071; "Can Edit Academic Year"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60072; "Can Process Graduation"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60073; "Can Process Senate Marks"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(60074; "Can Upload Marks"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//     }



// }

