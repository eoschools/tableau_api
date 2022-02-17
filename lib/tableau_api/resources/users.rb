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

      def create(username:, site_role: 'Viewer')
        raise 'invalid site_role' unless SITE_ROLES.include? site_role

        request = Builder::XmlMarkup.new.tsRequest do |ts|
          ts.user(name: username, siteRole: site_role)
        end

        res = @client.connection.api_post("sites/#{@client.auth.site_id}/users", body: request)

        res['tsResponse']['user'] if res.code == 201
      end

      def list
        url = "sites/#{@client.auth.site_id}/users"
        @client.connection.api_get_collection(url, 'users.user')
      end

      def find_by_username(username:)
        url = "sites/#{@client.auth.site_id}/users"
        res = @client.connection.api_get_collection(url, 'users.user', {query: "filter=name:eq:#{username}"})
        res.first
      end

      def update_user(user_id:, site_role:)
        raise 'invalid site_role' unless SITE_ROLES.include? site_role

        res = @client.connection.api_get("sites/#{@client.auth.site_id}/users/#{user_id}")

        raise 'failed to find user' if res.code != 200
        user = res['tsResponse']['user']

        request = Builder::XmlMarkup.new.tsRequest do |ts|
          ts.user(name: user['name'], siteRole: site_role)
        end

        res = @client.connection.api_put("sites/#{@client.auth.site_id}/users/#{user_id}", body: request)

        res['tsResponse']['user'] if res.code == 200
      end

      def remove_user(user_id:)
        res = @client.connection.api_delete("sites/#{@client.auth.site_id}/users/#{user_id}")

        raise 'failed to remove user' if res.code != 204

        res.code == 204
      end
    end
  end
end
