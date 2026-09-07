public with sharing class ParticipantCommunityUrl {
  private static final String COMMUNITY_NAME = 'Landing Page';
  private static String cachedPageUrl;

  public class ResolutionException extends Exception {
  }

  public static String pageUrl() {
    if (cachedPageUrl != null) {
      return cachedPageUrl;
    }
    List<Network> matches = [
      SELECT Id, Status
      FROM Network
      WHERE Name = :COMMUNITY_NAME
      LIMIT 2
    ];
    if (matches.size() != 1 || matches[0].Status != 'Live') {
      throw new ResolutionException(
        'La community Landing Page deve esistere, essere univoca e pubblicata.'
      );
    }
    ConnectApi.Community community = ConnectApi.Communities.getCommunity(
      matches[0].Id
    );
    if (
      community == null ||
      String.isBlank(community.siteUrl) ||
      !community.siteUrl.startsWith('https://')
    ) {
      throw new ResolutionException(
        'URL pubblico della community non disponibile.'
      );
    }
    String baseUrl = community.siteUrl;
    while (baseUrl.endsWith('/')) {
      baseUrl = baseUrl.substring(0, baseUrl.length() - 1);
    }
    cachedPageUrl = baseUrl + '/participant-registration';
    return cachedPageUrl;
  }

  public static String registrationUrl(Id accountId, Id campaignId) {
    if (
      accountId == null ||
      accountId.getSObjectType() != Account.SObjectType ||
      campaignId == null ||
      campaignId.getSObjectType() != Campaign.SObjectType
    ) {
      throw new ResolutionException(
        'Account e campagna evento sono obbligatori.'
      );
    }
    return pageUrl() +
      '?c__accountId=' +
      EncodingUtil.urlEncode(String.valueOf(accountId), 'UTF-8') +
      '&c__campaignId=' +
      EncodingUtil.urlEncode(String.valueOf(campaignId), 'UTF-8');
  }
}
