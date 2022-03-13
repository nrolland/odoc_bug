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
      Plus1Typed contains a Wrap.Abstract.Type, but its link is broken
    *)
  module type Plus1Typed = sig
    module Untyped : Wrap.Abstract.Type
    (** 
      The link to Wrap.Abstract.Type is broken
    *)
  end
end
