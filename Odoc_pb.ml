(** {2 From file} 

A link is broken when loaded from file
*)

include Odoc_intf.Wrap.Abstract
include Odoc

(** {2 From nested modules} 

Doing the same from nested module preserves the link which is broken with files

*)

module Nested = struct
  module WrapOdoc = struct
    module Odoc_intf = struct
      module Wrap = struct
        module Abstract_intf = struct
          module type Type = sig
            type concrete
          end

          module type Intf = sig
            module type Type
            (**  The abstract type Type from Wrap.Abstract*)
          end
        end

        module Abstract : Abstract_intf.Intf = Abstract_intf
      end

      module type Plus1Typed = sig
        module Untyped : Wrap.Abstract.Type
      end

      module type Intf = sig
        (** 
            Plus1Typed contains a Wrap.Abstract.Type, and its link is preserved 
          *)
        module type Plus1Typed = sig
          module Untyped : Wrap.Abstract.Type
          (** 
            The link to Wrap.Abstract.Type is preserved 
          *)
        end
      end
    end

    module Odoc : Odoc_intf.Intf = struct
      include Odoc_intf
    end
  end

  include WrapOdoc.Odoc_intf.Wrap.Abstract
  include WrapOdoc.Odoc
end
