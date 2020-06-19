with Alire.Conditional;
with Alire.Containers;
with Alire.Platforms;
with Alire.Properties;
with Alire.Requisites;
with Alire.TOML_Adapters;
with Alire.Utils;

package Alire.Externals is

   --  External releases do not have an actual version until detected at
   --  runtime. Hence, they cannot be catalogued in the index with a known
   --  version. Instead, they're listed under the 'external' array.

   type External is abstract tagged private;

   function Detect (This : External;
                    Name : Crate_Name) return Containers.Release_Set
                    is abstract;
   --  Perform detection and return all matching releases. Empty set must be
   --  returned if nothing can be detected. Checked_Error must be raised if
   --  detection cannot be performed normally. Caching results is allowed.
   --  Name is a convenience so Releases can be created without requiring the
   --  full containing crate reference.

   function Image (This : External) return String is abstract;
   --  Short one-liner textual description

   function Detail (This   : External;
                    Distro : Platforms.Distributions)
                    return Utils.String_Vector is abstract;
   --  Detailed longer textual description of specifics. If Distro /= Unknown,
   --  show only the relevant distro information.

   function Kind (This : External) return String is abstract;
   --  Keyword for use in `alr show` and similar displays of information

   -------------------------
   --  Classwide helpers  --
   -------------------------

   function Available (This : External'Class) return Requisites.Tree;

   type Kinds is (Hint,
                  --  A placeholder for a knowingly-unavailable crate, that
                  --  will hopefully be added in the future.

                  Softlink,
                  --  A directory that is used in place, with indeterminate
                  --  version.

                  System,
                  --  A installed system package, via apt, yum, etc.

                  Version_Output
                  --  A external that detects the availability of a tool by
                  --  running it to detect its version.
                 );
   --  These kinds are used during TOML loading, and exposed in the spec for
   --  documentation purposes only.

   function From_TOML (From : TOML_Adapters.Key_Queue) return External'Class;

   function On_Platform (This : External'Class;
                         Env  : Properties.Vector) return External'Class;
   --  Evaluate Properties and Available fields under the given environment

private

   type External is abstract tagged record
      Properties : Conditional.Properties;
      Available  : Requisites.Tree;
   end record;

end Alire.Externals;
