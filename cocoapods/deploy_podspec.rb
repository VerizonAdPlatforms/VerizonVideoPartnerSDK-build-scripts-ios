module Fastlane
  module Actions
    class DeployPodspecAction < Action
      def self.run(params)
        podspec = params[:podspec_path]
        spec_repo_name = params[:spec_repo_name]
        spec_repo_url = params[:spec_repo_url]
        swift_version = params[:swift_version]
        sh "pod repo add #{spec_repo_name} #{spec_repo_url}" unless sh("pod repo list").include? spec_repo_name
        sh "pod repo push #{spec_repo_name} #{podspec} --swift-version=#{swift_version}"
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Deploy podspec to the spec repo"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :podspec_path,
                                       description: "Podspec path + name",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :spec_repo_name,
                                       description: "CocoaPods spec repository name.",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :spec_repo_url,
                                       description: "CocoaPods spec repository url.",
                                       is_string: true,
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :swift_version,
                                       description: "Swift version.",
                                       is_string: true,
                                       optional: false)
        ]
      end

      def self.authors
        ["AndriiMoskvin/Berk0ld"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
