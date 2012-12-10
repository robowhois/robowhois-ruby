#--
# RoboWhois
#
# Ruby client for the RoboWhois API.
#
# Copyright (c) 2012 Aetrion LLC.
#++


class RoboWhois

  # Holds information about library version.
  module Version
    MAJOR = 0
    MINOR = 2
    PATCH = 2
    BUILD = nil

    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join(".")
  end

  # The current library version.
  VERSION = Version::STRING

end
