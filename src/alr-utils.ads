private with Ada.Strings;
private with Ada.Strings.Fixed;

with Ada.Containers.Indefinite_Vectors;

package Alr.Utils is
   
   --  Miscellaneous utilities
         
   function To_Lower_Case (S : String) return String;
   function To_Mixed_Case (S : String) return String;

   function Contains (Text : String; Sub : String) return Boolean;
   
   function Quote (S : String) return String;
   
   function Replace (Text : String; Match : String; Subst : String) return String;
   
   function Trim (S : String) return String;

   function Hash_File (Path : String) return String;
   --  Returns the hexadecimal representation

   --  General containers
   
   package String_Vectors is new Ada.Containers.Indefinite_Vectors (Positive, String);
   subtype String_Vector is String_Vectors.Vector;   
   
private
   
   function Quote (S : String) return String is ("""" & S & """");

   function Trim (S : String) return String is
     (Ada.Strings.Fixed.Trim (S, Ada.Strings.Both));
   
   function Contains (Text : String; Sub : String) return Boolean is
      (Ada.Strings.Fixed.Count (Text, Sub) > 0);
   
end Alr.Utils;