module OpenID
  class Consumer
    class AssociationManager
      def get_association_with_skip_for_google
        # Google no longer wants the assoc_handle parameter when authenticating by OpenID, and passing it in causes
        # it to always respond that the request is invalid. To get around this, if we're using google, just don't
        # collect/create an association, so no handle will be used in the request.
        # See: https://groups.google.com/forum/#!topic/google-federated-login-api/qXZDD7_K7jU
        return nil if @server_url == "https://www.google.com/accounts/o8/ud"

        return nil if @server_url and @server_url.starts_with?("https://www.google.com/accounts/o8/site-xrds")

        get_association_without_skip_for_google
      end

      alias_method_chain :get_association, :skip_for_google
    end
  end
end
