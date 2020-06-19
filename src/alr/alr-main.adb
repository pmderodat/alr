with Alire;
with Alire_Early_Elaboration; pragma Elaborate_All (Alire_Early_Elaboration);
with Alire.Root;

with Alr.Bootstrap;
with Alr.Commands;
with Alr.Platform.Init;
with Alr.Platforms.Current;

with Last_Chance_Handler;

procedure Alr.Main is
begin
   Alr.Platform.Init (Alr.Platforms.Current.New_Platform);

   --  Get an instance of the current platform and pass its properties to
   --  Alire. This is a temporary situation until all of Alr.Platform is
   --  refactored into Alire. TODO: remove during the refactor. During the
   --  same refactor, the above creation and setting of an instance can be
   --  made unnecessary if we rely on a common spec instead of on a common base
   --  class. That will also allow having the platform properties available
   --  during elaboration. TODO: during the refactor, convert from tagged
   --  type to shared specification. All of this should be done on Issue #335.

   Alire.Root.Set_Platform_Properties (Alr.Platform.Properties);

   Trace.Detail ("alr build is " & Bootstrap.Status_Line);

   Commands.Execute;
exception
   when E : others =>
      Last_Chance_Handler (E);
end Alr.Main;
