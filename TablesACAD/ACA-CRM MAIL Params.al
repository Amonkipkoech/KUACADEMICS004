// table 86566 "CRM Mail Parameters"
// {
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Mail Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;

//         }
//         field(2; "Mail Batch"; Code[20])
//         {
//             DataClassification = ToBeClassified;

//         }
//         field(3; "Cc 1"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             ExtendedDatatype = Email;
//         }
//         field(4; "Cc 2"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             ExtendedDatatype = Email;
//         }

//         field(5; "Cc 3"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             ExtendedDatatype = Email;
//         }

//         field(6; "Cc 4"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             ExtendedDatatype = Email;
//         }
//         field(7; "BCc 1"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             ExtendedDatatype = Email;
//         }
//         field(8; "BCc 2"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             ExtendedDatatype = Email;
//         }

//         field(9; "BCc 3"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//             ExtendedDatatype = Email;
//         }

//         field(10; "Email Subject"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             ExtendedDatatype = Email;
//         }

//         field(11; "Email Body"; Text[250])
//         {
//             DataClassification = ToBeClassified;
            
//         }

//         field(12; "Email Body 2"; Text[250])
//         {
//             DataClassification = ToBeClassified;

//         }

//     }

//     keys
//     {
//         key(Key1; "Mail Code")
//         {
//             Clustered = true;
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnInsert()
//     begin

//     end;

//     trigger OnModify()
//     begin

//     end;

//     trigger OnDelete()
//     begin

//     end;

//     trigger OnRename()
//     begin

//     end;

// }