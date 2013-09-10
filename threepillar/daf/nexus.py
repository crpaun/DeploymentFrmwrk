__author__ = 'asfat'


class NexusApiClient:
    NEXUS_URL = 'http://localhost/nexus' 
    NEXUS_REDIRECT_SERVICE = '/service/local/artifact/maven/redirect'
    DEFAULT_GROUP_ID = '3Pillar'
    RELEASES_REPOSITORY = 'releases'
    SNAPSHOTS_REPOSITORY = 'snapshots'
    REPOSITORY_PARAMETER = 'r='
    GROUPID_PARAMETER = 'g='
    ARTIFACTID_PARAMETER = 'a='
    VERSION_PARAMETER = 'v='
    EXTENSION_PARAMETER = 'e='

    def __init__(self,
                 NEXUS_URL="http://abc/nexus",
                 artifactid=None,
                 groupid=DEFAULT_GROUP_ID,
                 version=None,
                 snapshot_or_release_version='SNAPSHOT',
                 extension=None):
        self.NEXUS_URL = NEXUS_URL;
        self.artifact_id = artifactid
        self.group_id = groupid
        self.version = version
        self.snapshot_or_release_version = snapshot_or_release_version
        self.extension = extension
        self.final_version = self.version

        if self.snapshot_or_release_version == 'SNAPSHOT':
            self.artifact = '%s-%s-%s.%s' % (self.artifact_id, self.version, "SNAPSHOT", self.extension)
            self.final_version = self.version + '-SNAPSHOT'
            self.repository_used = self.SNAPSHOTS_REPOSITORY
        else:
            self.artifact = '%s-%s.%s' % (self.artifact_id, self.version, self.extension)
            self.repository_used = self.RELEASES_REPOSITORY

    def build_url(self):
        url = self.NEXUS_URL + self.NEXUS_REDIRECT_SERVICE + '?'
        url += self.GROUPID_PARAMETER + self.group_id + '&'
        url += self.ARTIFACTID_PARAMETER + self.artifact_id + '&'
        url += self.REPOSITORY_PARAMETER + self.repository_used + '&'
        url += self.VERSION_PARAMETER + self.final_version + '&'
        url += self.EXTENSION_PARAMETER + self.extension

        return url
