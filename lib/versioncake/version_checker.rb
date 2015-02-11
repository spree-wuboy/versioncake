module VersionCake
  class VersionChecker
    attr_reader :result
    def initialize(version, resource)
      @version, @resource = resource, version
    end

    def execute
      @result = if @version.nil?
        :no_version
      elsif @resource.supported_versions.include? @version
        :supported
      elsif @resource.obsolete_versions.include? @version
        :obsolete
      elsif @resource.deprecated_versions.include? @version
        :deprecated
      elsif @version > @resource.supported_versions.last
        :version_too_high
      elsif @version < @resource.supported_versions.first
        :version_too_low
      else
        :unknown
      end
    end
  end
end
