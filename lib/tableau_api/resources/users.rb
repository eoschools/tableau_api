module TableauApi
  module Resources
    class Users < Base
      SITE_ROLES = %w[
        Creator
        Explorer
        ExplorerCanPublish
        SiteAdministratorCreator
        SiteAdministratorExplorer
        ServerAdministrator
        Unlicensed
        Viewer
      ].freeze

      def create(name:, site_role: 'Viewer')
        raise 'invalid site_role' unless SITE_ROLES.include? site_role

        request = Builder::XmlMarkup.new.tsRequest do |ts|
          ts.user(name: name, siteRole: site_role)
        end

        res = @client.connection.api_post("sites/#{@client.auth.site_id}/users", body: request)

        res['tsResponse']['user'] if res.code == 201
      end

      def list
        url = "sites/#{@client.auth.site_id}/users"
        @client.connection.api_get_collection(url, 'users.user')
      end

      def find_by_name(name:)
        url = "sites/#{@client.auth.site_id}/users"
        res = @client.connection.api_get_collection(url, 'users.user', **{query: "filter=name:eq:#{name}"})
        res.first
      end

      def update_user(**parms)
        parms = parms.transform_keys{|k| k.to_s.camelcase(:lower)}
        user_id = parms.delete("userId")
        raise "invalid or missing user_id #{user_id} - #{parms}" if user_id.nil?
        raise 'invalid site_role' unless parms["siteRole"].nil? || SITE_ROLES.include?(parms["siteRole"])

        res = @client.connection.api_get ["sites", @client.auth.site_id, "users", user_id].join("/")
        raise 'failed to get user for update' if res.code != 200

        user = res['tsResponse']['user']
        # parms["name"] ||= user["name"]
        parms["siteRole"] ||= user["siteRole"]
        request = Builder::XmlMarkup.new.tsRequest do |ts|
          ts.user(parms)
        end
        res = @client.connection.api_put(["sites", @client.auth.site_id, "users", user_id].join("/"), body: request)
        res['tsResponse']['user'] if res.code == 200
      end

      def remove_user(name:)
        user = find_by_name(name: name)
        res = @client.connection.api_delete("sites/#{@client.auth.site_id}/users/#{user['id']}")
        raise 'failed to remove user' if res.code != 204

        res.code == 204
      end
    end
  end
end
