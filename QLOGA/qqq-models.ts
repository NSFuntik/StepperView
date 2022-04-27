/* tslint:disable */
/* eslint-disable */
// Generated using typescript-generator version 2.32.889 on 2022-03-06 19:28:03.

export interface LatLng {
    lat: number;
    lng: number;
}

export interface ChatMessage {
    id: number;
    posted: Date;
    groupId: number;
    senderId: number;
    service: boolean;
    updated: Date;
    message: string;
}

export interface ChatMessageUpdateRequest {
    id: number;
    text: string;
}

export interface Notification {
    id: number;
    type: NotificationType;
    sent: Date;
    object: any;
    channel: NotificationChannel;
    receiverId: number;
    read: Date;
}

export interface OktaLifecycleChange {
    id: number;
    status: string;
}

export interface Address extends CachedDTO, ILatLng {
    familyId: number;
    country: string;
    line1: string;
    line2: string;
    line3: string;
    line4: string;
    town: string;
    postcode: string;
    parking: Parking;
    zoneId: string;
    timeOffset: number;
    vrfs: Verification[];
    businessOnly: boolean;
}

export interface CachedDTO {
    id: number;
}

export interface ChatGroup extends CachedDTO {
    name: string;
    managed: boolean;
    module: QModule;
    ctxObjectId: number;
    ctxObjectType: string;
    ownerId: number;
    created: Date;
    silent: boolean;
    p2p: boolean;
    avatarId: number;
    chatters: Chatter[];
}

export interface Chatter extends CachedDTO {
    personId: number;
    groupId: number;
    moderator: boolean;
    muted: boolean;
    joined: Date;
}

export interface EPDQStatusDetails {
    status: any;
    visibility: EPDQStatusVisibility;
    descr: string;
}

export interface EmailAttachMeta extends CachedDTO {
    emailMeta: EmailMeta;
    filename: string;
    contentType: string;
    size: number;
}

export interface EmailMeta extends CachedDTO {
    from: string;
    to: string;
    personId: number;
    subject: string;
    inout: boolean;
    when: Date;
    s3ObjectId: string;
    size: number;
    attachments: EmailAttachMeta[];
}

export interface Family extends CachedDTO {
    name: string;
    descr: string;
    dateFrom: Date;
    headId: number;
    avatarId: number;
    settings: { [index: string]: string };
    subscriptions: Subscription[];
    chatGroupId: number;
    cal: Cal;
}

export interface ILatLng {
    lat: number;
    lng: number;
}

export interface Id {
    id: number;
}

export interface IdNameAvatar {
    id: number;
    name: string;
    avatarId: number;
    avatarUrl: string;
}

export interface MediaAlbum extends CachedDTO {
    name: string;
    descr: string;
    updatedDate: Date;
    medias: MediaMeta[];
    ownerId: number;
    ownerFamilyId: number;
    avatarId: number;
    access: AccessLevel;
}

export interface MediaMeta extends CachedDTO {
    filename: string;
    summary: string;
    contentType: string;
    width: number;
    height: number;
    size: number;
    uploadedDate: Date;
    access: AccessLevel;
    uploaderId: number;
    vrfs: Verification[];
}

export interface News extends CachedDTO {
    summary: string;
    description: string;
    published: Date;
    ends: Date;
    publicationType: NewsPublicationTypeEnum;
    priority: number;
    mediaId: number;
}

export interface OffTime extends CachedDTO {
    from: Date;
    to: Date;
}

export interface OnlineUser {
    id: number;
    connected: Date;
}

export interface Org extends CachedDTO {
    name: string;
    descr: string;
    adminId: number;
    avatarId: number;
    active: boolean;
    individual: boolean;
    email: string;
    website: string;
    nonForProfit: boolean;
    phoneCountry: string;
    phoneNumber: number;
    regDetails: string;
    insurance: string;
    admin: OrgAdminPublicProfile;
    addr: Address;
    offTime: OffTime[];
    workingHours: WorkHours[];
    verifications: Verification[];
    langs: string[];
    settings: { [index: string]: string };
    cal: Cal;
}

export interface OrgAdminPublicProfile extends CachedDTO {
    fname: string;
    mname: string;
    madenname: string;
    sname: string;
    avatarId: number;
    address: Address;
    email: string;
    vrfs: Verification[];
    phone: string;
}

export interface PayAuthResult {
    targetUrl: string;
    payTxn: PayTxn;
    params: { [index: string]: string };
}

export interface PayMethod extends CachedDTO {
    payId: number;
    cardholderName: string;
    brand: string;
    expiryDate: Date;
    last4: number;
    active: boolean;
    defaultMethod: boolean;
}

export interface PayTxn extends CachedDTO {
    payerId: number;
    date: Date;
    refId: number;
    refType: PayTxnRefType;
    payId: number;
    paySubId: number;
    errCode: number;
    errText: string;
    status: number;
    statusText: string;
    cardholder: string;
    brand: string;
    expiryDate: Date;
    last4: number;
    amount: number;
}

export interface Person extends CachedDTO {
    familyId: number;
    fname: string;
    mname: string;
    madenname: string;
    sname: string;
    cognitoId: string;
    email: string;
    phoneCountry: string;
    phoneNumber: number;
    gender: Gender;
    dob: Date;
    created: Date;
    phoneVerified: boolean;
    avatarVerified: boolean;
    avatarId: number;
    verifications: Verification[];
    settings: { [index: string]: string };
    langs: string[];
    address: Address;
    oktaStatus: string;
    oktaStatusUpdated: Date;
    payMethods: PayMethod[];
    cal: Cal;
}

export interface PersonPublicProfile extends CachedDTO {
    familyDescr: string;
    fname: string;
    mname: string;
    madenname: string;
    sname: string;
    avatarId: number;
    address: Address;
    email: string;
    vrfs: Verification[];
    phone: string;
}

export interface RegistrationRequest {
    fname: string;
    sname: string;
    dob: Date;
    email: string;
    gender: Gender;
}

export interface Relative {
    kin: FamilyRole;
    person: Person;
}

export interface StatusRecord {
    date: Date;
    actor: ActorsEnum;
    actorId: number;
    action: string;
    note: string;
    status: string;
    display: string;
    actionDisplay: string;
    actionPast: string;
}

export interface Subscription extends CachedDTO {
    familyId: number;
    product: Product;
    from: Date;
    to: Date;
    note: string;
    suspended: Date;
    payments: PayTxn[];
}

export interface Triple<X, Y, Z> {
    x: X;
    y: Y;
    z: Z;
}

export interface Tuple<X, Y> {
    x: X;
    y: Y;
}

export interface Verification extends CachedDTO {
    type: VerificationType;
    holderType: VerificationHolderType;
    subjId: number;
    holderId: number;
    date: Date;
    expires: Date;
    notes: string;
}

export interface WorkHours extends CachedDTO {
    weekDay: DayOfWeek;
    from: string;
    to: string;
}

export interface Cal extends CachedDTO {
    name: string;
    type: CalType;
    refId: number;
}

export interface Event extends CachedDTO {
    type: EventType;
    frequency: Recurrence;
    from: Date;
    to: Date;
    title: string;
    recurrenceEnds: Date;
    notes: string;
    seriesEventId: number;
    ctxObjectId: number;
    ctxData: string;
    parties: EventParty[];
    day: boolean;
    untfWhen: number;
    untfType: EventNotificationType;
    ustatus: EventPartyStatus;
    ucal: Cal;
}

export interface EventDataHoliday {
}

export interface EventDataOrder {
    orderId: number;
    cstId: number;
    cstAvatarId: number;
    prvOrgId: number;
    prvOrgAdminId: number;
    prvOrgAvatarId: number;
    prvOrgName: string;
    orderToAddress: string;
    serviceDT: Date;
    amount: number;
    services: { [index: string]: IdNameAvatar[] };
}

export interface EventDataOrg {
    orgId: number;
    orgAdminId: number;
    prvOrgAvatarId: number;
    orgName: string;
}

export interface EventDataRq {
}

export interface EventParty {
    personId: number;
    calId: number;
    status: EventPartyStatus;
}

export interface ScannedEvent {
    personId: number;
    event: Event;
}

export interface ClearanceType extends CachedDTO {
    descr: string;
    name: string;
}

export interface Country extends CachedDTO {
    iso2: string;
    iso3: string;
    dialcode: string;
    descr: string;
}

export interface CountryDefaultWorkHours extends CachedDTO {
    iso2: string;
    weekDay: DayOfWeek;
    from: string;
    to: string;
}

export interface CountryHoliday extends CachedDTO {
    countryIso2: string;
    descr: string;
    note: string;
    area: string;
    publicHoliday: boolean;
    from: Date;
    to: Date;
}

export interface IdType extends CachedDTO {
    descr: string;
    name: string;
}

export interface Lang extends CachedDTO {
    code: string;
    descr: string;
}

export interface Product extends CachedDTO {
    recurrence: Recurrence;
    type: ProductType;
    note: string;
    price: number;
    active: boolean;
}

export interface ProductType extends CachedDTO {
    avatarId: number;
    code: ProductCode;
    name: string;
    descr: string;
}

export enum DayOfWeek {
    MONDAY = "MONDAY",
    TUESDAY = "TUESDAY",
    WEDNESDAY = "WEDNESDAY",
    THURSDAY = "THURSDAY",
    FRIDAY = "FRIDAY",
    SATURDAY = "SATURDAY",
    SUNDAY = "SUNDAY",
}

export enum AccessLevel {
    PRIVATE = "PRIVATE",
    FAMILY = "FAMILY",
    PUBLIC = "PUBLIC",
    ALL = "ALL",
}

export enum ActorsEnum {
    QLOGA = "QLOGA",
    CUSTOMER = "CUSTOMER",
    PROVIDER = "PROVIDER",
    RESOURCE = "RESOURCE",
    JOB_APPLICANT = "JOB_APPLICANT",
}

export enum AvatarType {
    PERSON = "PERSON",
    FAMILY = "FAMILY",
    ALBUM = "ALBUM",
    ORG = "ORG",
}

export enum CalType {
    PERSONAL = "PERSONAL",
    FAMILY = "FAMILY",
    P4P_CST = "P4P_CST",
    P4P_PRV = "P4P_PRV",
    ORG = "ORG",
    PUBLIC = "PUBLIC",
}

export enum ChatGroupType {
    P2P = "P2P",
    USER_MANAGED = "USER_MANAGED",
    FAMILY = "FAMILY",
    ORDER = "ORDER",
    ASSIGN = "ASSIGN",
    REQUEST = "REQUEST",
    SUBSCRIPTION = "SUBSCRIPTION",
}

export enum DistanceUnits {
    MILES = "MILES",
    KILOMETERS = "KILOMETERS",
    NAUTICAL_MILES = "NAUTICAL_MILES",
}

export enum EPDQStatusVisibility {
    DONT = "DONT",
    CST = "CST",
    BOTH = "BOTH",
}

export enum ErrorCode {
    ORDER_NO_VISIT_TODAY = "ORDER_NO_VISIT_TODAY",
    ORDER_WRONG_VISIT_NUMBER = "ORDER_WRONG_VISIT_NUMBER",
    ORDER_CANNOT_COMPLETE_BEFORE_STARTING = "ORDER_CANNOT_COMPLETE_BEFORE_STARTING",
    BUTTON_CLICKED_TWICE = "BUTTON_CLICKED_TWICE",
    ORDER_ARRIVED_TOO_FAR = "ORDER_ARRIVED_TOO_FAR",
    ORDER_ARRIVED_TOO_EARLY = "ORDER_ARRIVED_TOO_EARLY",
    ORDER_ARRIVED_TOO_LATE = "ORDER_ARRIVED_TOO_LATE",
    ORDER_CANNOT_BE_EMPTY = "ORDER_CANNOT_BE_EMPTY",
    ORDER_SERVICE_DATE_MUST_BE_SPECIFIED = "ORDER_SERVICE_DATE_MUST_BE_SPECIFIED",
    ORDER_DATE_IS_IN_THE_PAST = "ORDER_DATE_IS_IN_THE_PAST",
    ORDER_PRV_NOT_ARRIVED_TOO_EARLY = "ORDER_PRV_NOT_ARRIVED_TOO_EARLY",
    ORDER_DAILY_PLAN_IS_A_MUST = "ORDER_DAILY_PLAN_IS_A_MUST",
    PEOPLE_LIVE_AT_ADDR = "PEOPLE_LIVE_AT_ADDR",
    OFFER_BELOW_MIN_WAGE = "OFFER_BELOW_MIN_WAGE",
    REQUEST_CANNOT_BE_DELETED = "REQUEST_CANNOT_BE_DELETED",
    ORDER_CANNOT_BE_DELETED = "ORDER_CANNOT_BE_DELETED",
    HRES_IS_NOT_AVAILABLE = "HRES_IS_NOT_AVAILABLE",
    SENIOR_IS_SET = "SENIOR_IS_SET",
    HRES_WORK_HRS_NOT_SET = "HRES_WORK_HRS_NOT_SET",
    HRES_OUT_OF_WRK_HRS = "HRES_OUT_OF_WRK_HRS",
    PRV_DOES_NOT_SPEAK_CST_LANGUAGE = "PRV_DOES_NOT_SPEAK_CST_LANGUAGE",
    PRV_OFF_TIME = "PRV_OFF_TIME",
    PRV_WRK_HRS = "PRV_WRK_HRS",
    ADDR_IS_MANDATORY = "ADDR_IS_MANDATORY",
    JOB_CANNOT_BE_DELETED_DUE_TO_APPS = "JOB_CANNOT_BE_DELETED_DUE_TO_APPS",
    JOB_CANNOT_BE_DELETED_CLOSED = "JOB_CANNOT_BE_DELETED_CLOSED",
    ORG_DOES_NOT_HAVE_LANGS = "ORG_DOES_NOT_HAVE_LANGS",
    DAY_PLAN_FOR_THE_DAY_IS_NOT_SET = "DAY_PLAN_FOR_THE_DAY_IS_NOT_SET",
}

export enum FamilyKinship {
    marriage = "marriage",
    ex_marriage = "ex_marriage",
    partnership = "partnership",
    ex_partnership = "ex_partnership",
    friendship = "friendship",
    parentage = "parentage",
    adoption = "adoption",
    siblings = "siblings",
    stepsiblings = "stepsiblings",
    other = "other",
}

export enum FamilyRole {
    mother = "mother",
    father = "father",
    stepfather = "stepfather",
    stepmother = "stepmother",
    mother_in_law = "mother_in_law",
    father_in_law = "father_in_law",
    husband = "husband",
    wife = "wife",
    ex_husband = "ex_husband",
    ex_wife = "ex_wife",
    partner = "partner",
    ex_partner = "ex_partner",
    ex_spouse = "ex_spouse",
    son = "son",
    daughter = "daughter",
    stepson = "stepson",
    stepdaughter = "stepdaughter",
    son_in_law = "son_in_law",
    daughter_in_law = "daughter_in_law",
    brother = "brother",
    sister = "sister",
    stepsister = "stepsister",
    stepbrother = "stepbrother",
    brother_in_law = "brother_in_law",
    sister_in_law = "sister_in_law",
    aunt = "aunt",
    uncle = "uncle",
    nephew = "nephew",
    niece = "niece",
    cousin = "cousin",
    grandfather = "grandfather",
    grandmother = "grandmother",
    stepgrandmother = "stepgrandmother",
    stepgrandfather = "stepgrandfather",
    grandson = "grandson",
    granddaughter = "granddaughter",
    great_grandfather = "great_grandfather",
    great_grandmother = "great_grandmother",
    great_grandson = "great_grandson",
    great_granddaughter = "great_granddaughter",
    friend = "friend",
    boyfriend = "boyfriend",
    girlfriend = "girlfriend",
    ex_boyfriend = "ex_boyfriend",
    ex_girlfriend = "ex_girlfriend",
    low_ancestor = "low_ancestor",
    high_ancestor = "high_ancestor",
    adoptee = "adoptee",
    adopting_parent = "adopting_parent",
    not_set = "not_set",
    other = "other",
}

export enum Gender {
    MALE = "MALE",
    FEMALE = "FEMALE",
    UNISEX = "UNISEX",
}

export enum Lookups {
    all = "all",
    countries = "countries",
    langs = "langs",
    id_types = "id_types",
    clearance_types = "clearance_types",
    country_work_hours = "country_work_hours",
    country_holidays = "country_holidays",
    event_types = "event_types",
    vrf_types = "vrf_types",
    products = "products",
    epdq_ops = "epdq_ops",
    paytxn_statuses = "paytxn_statuses",
}

export enum NewsPublicationTypeEnum {
    QLOGA = "QLOGA",
    FAMILY = "FAMILY",
    PERSONAL = "PERSONAL",
}

export enum OrgAdminPublicProfileKey {
    ORG_ADMIN_PPROFILE_FNAME = "ORG_ADMIN_PPROFILE_FNAME",
    ORG_ADMIN_PPROFILE_MNAME = "ORG_ADMIN_PPROFILE_MNAME",
    ORG_ADMIN_PPROFILE_SNAME = "ORG_ADMIN_PPROFILE_SNAME",
    ORG_ADMIN_PPROFILE_LINE1 = "ORG_ADMIN_PPROFILE_LINE1",
    ORG_ADMIN_PPROFILE_LINE2 = "ORG_ADMIN_PPROFILE_LINE2",
    ORG_ADMIN_PPROFILE_LINE3 = "ORG_ADMIN_PPROFILE_LINE3",
    ORG_ADMIN_PPROFILE_LINE4 = "ORG_ADMIN_PPROFILE_LINE4",
    ORG_ADMIN_PPROFILE_TOWN = "ORG_ADMIN_PPROFILE_TOWN",
    ORG_ADMIN_PPROFILE_POSTCODE = "ORG_ADMIN_PPROFILE_POSTCODE",
    ORG_ADMIN_PPROFILE_COUNTRY = "ORG_ADMIN_PPROFILE_COUNTRY",
    ORG_ADMIN_PPROFILE_AVATAR = "ORG_ADMIN_PPROFILE_AVATAR",
    ORG_ADMIN_PPROFILE_PHONE = "ORG_ADMIN_PPROFILE_PHONE",
    ORG_ADMIN_PPROFILE_EMAIL = "ORG_ADMIN_PPROFILE_EMAIL",
    ORG_ADMIN_PPROFILE_VRF_ID = "ORG_ADMIN_PPROFILE_VRF_ID",
    ORG_ADMIN_PPROFILE_VRF_ADDRESS = "ORG_ADMIN_PPROFILE_VRF_ADDRESS",
    ORG_ADMIN_PPROFILE_VRF_PHONE = "ORG_ADMIN_PPROFILE_VRF_PHONE",
}

export enum Parking {
    PAID = "PAID",
    FREE = "FREE",
}

export enum PayTxnRefType {
    subscr = "subscr",
    order = "order",
}

export enum ProductCode {
    PREMIUM = "PREMIUM",
    P4P_INDIVIDUAL = "P4P_INDIVIDUAL",
    BUNDLE_P4P_INDIVIDUAL = "BUNDLE_P4P_INDIVIDUAL",
    P4P_FULL = "P4P_FULL",
    BUNDLE_P4P_FULL = "BUNDLE_P4P_FULL",
}

export enum PublicProfileKey {
    PPROFILE_FAMILY_DESCR = "PPROFILE_FAMILY_DESCR",
    PPROFILE_FNAME = "PPROFILE_FNAME",
    PPROFILE_MNAME = "PPROFILE_MNAME",
    PPROFILE_SNAME = "PPROFILE_SNAME",
    PPROFILE_MAIDENNAME = "PPROFILE_MAIDENNAME",
    PPROFILE_LINE1 = "PPROFILE_LINE1",
    PPROFILE_LINE2 = "PPROFILE_LINE2",
    PPROFILE_LINE3 = "PPROFILE_LINE3",
    PPROFILE_LINE4 = "PPROFILE_LINE4",
    PPROFILE_TOWN = "PPROFILE_TOWN",
    PPROFILE_POSTCODE = "PPROFILE_POSTCODE",
    PPROFILE_COUNTRY = "PPROFILE_COUNTRY",
    PPROFILE_AVATAR = "PPROFILE_AVATAR",
    PPROFILE_PHONE = "PPROFILE_PHONE",
    PPROFILE_EMAIL = "PPROFILE_EMAIL",
    PPROFILE_VRF_ID = "PPROFILE_VRF_ID",
    PPROFILE_VRF_ADDRESS = "PPROFILE_VRF_ADDRESS",
    PPROFILE_VRF_PHONE = "PPROFILE_VRF_PHONE",
}

export enum QModule {
    BASIC = "BASIC",
    P4P = "P4P",
    POSTCARDS = "POSTCARDS",
    FLOWERS = "FLOWERS",
    GIFTS = "GIFTS",
    QUIZ = "QUIZ",
}

export enum Recurrence {
    ONEOFF = "ONEOFF",
    YEARLY = "YEARLY",
    MONTHLY = "MONTHLY",
    WEEKLY = "WEEKLY",
    DAILY = "DAILY",
}

export enum SettingsKeys {
    PRV_LANGS_ONLY = "PRV_LANGS_ONLY",
    CST_LANGS_ONLY = "CST_LANGS_ONLY",
    PRV_WORKTIME_ONLY = "PRV_WORKTIME_ONLY",
    UK_MIN_WAGE = "UK_MIN_WAGE",
    GCP_KEY = "GCP_KEY",
    GETADDRESS_KEY = "GETADDRESS_KEY",
}

export enum SettingsScope {
    QLOGA = "QLOGA",
    FAMILY = "FAMILY",
    PERSON = "PERSON",
    ORG = "ORG",
}

export enum SubscriptionType {
    PREMIUM = "PREMIUM",
    P4P_INDIVIDUAL = "P4P_INDIVIDUAL",
    P4P_AGENCY = "P4P_AGENCY",
    POSTCARDS = "POSTCARDS",
    FLOWERS = "FLOWERS",
    GIFTS = "GIFTS",
}

export enum TimeSubject {
    ORG = "ORG",
    P4P_HRES = "P4P_HRES",
    P4P_JOB_APP = "P4P_JOB_APP",
}

export enum VerificationHolderType {
    PERSON = "PERSON",
    ORG = "ORG",
}

export enum VerificationType {
    ID = "ID",
    PHONE = "PHONE",
    ADDRESS = "ADDRESS",
    CLEARANCE = "CLEARANCE",
    MEDIA = "MEDIA",
    LEGAL_STATUS = "LEGAL_STATUS",
    ORG_INSURANCE = "ORG_INSURANCE",
    ORG_EMAIL = "ORG_EMAIL",
    ORG_PHONE = "ORG_PHONE",
    ORG_REGISTRATION = "ORG_REGISTRATION",
    ORG_ADDRESS = "ORG_ADDRESS",
}

export enum WarningCode {
    COORDS_FAR_FROM_ADDR_POSTCODE = "COORDS_FAR_FROM_ADDR_POSTCODE",
}

export enum NotificationChannel {
    PUBLIC = "PUBLIC",
    FAMILY = "FAMILY",
    PERSON = "PERSON",
}

export enum NotificationType {
    FAMILY_UPDATED = "FAMILY_UPDATED",
    FAMILY_KIN_UPDATED = "FAMILY_KIN_UPDATED",
    ADDRESS_ADDED = "ADDRESS_ADDED",
    ADDRESS_UPDATED = "ADDRESS_UPDATED",
    ADDRESS_REMOVED = "ADDRESS_REMOVED",
    ORG_ADDED = "ORG_ADDED",
    ORG_UPDATED = "ORG_UPDATED",
    ORG_DELETED = "ORG_DELETED",
    CHAT_MSG_ADDED = "CHAT_MSG_ADDED",
    CHAT_MSG_DELETED = "CHAT_MSG_DELETED",
    CHAT_MSG_UPDATED = "CHAT_MSG_UPDATED",
    CHAT_GROUP_ADDED = "CHAT_GROUP_ADDED",
    CHAT_GROUP_DELETED = "CHAT_GROUP_DELETED",
    CHAT_GROUP_UPDATED = "CHAT_GROUP_UPDATED",
    CHATTER_ADDED = "CHATTER_ADDED",
    CHATTER_DELETED = "CHATTER_DELETED",
    CHATTER_UPDATED = "CHATTER_UPDATED",
    RELATIVE_ADDED = "RELATIVE_ADDED",
    RELATIVE_UPDATED = "RELATIVE_UPDATED",
    USER_CONNECTED = "USER_CONNECTED",
    USER_DISCONNECTED = "USER_DISCONNECTED",
    USER_OKTA_STATUS_UPDATED = "USER_OKTA_STATUS_UPDATED",
    MEDIA_ADDED = "MEDIA_ADDED",
    MEDIA_UPDATED = "MEDIA_UPDATED",
    MEDIA_REMOVED = "MEDIA_REMOVED",
    ALBUM_ADDED = "ALBUM_ADDED",
    ALBUM_UPDATED = "ALBUM_UPDATED",
    ALBUM_REMOVED = "ALBUM_REMOVED",
    PUBLIC_SETTINGA_UPDATED = "PUBLIC_SETTINGA_UPDATED",
    COUNTRY_HOLIDAY = "COUNTRY_HOLIDAY",
    SUBSCRIPTION_ADDED = "SUBSCRIPTION_ADDED",
    SUBSCRIPTION_EXTENDED = "SUBSCRIPTION_EXTENDED",
    SUBSCRIPTION_CANCELLED = "SUBSCRIPTION_CANCELLED",
    SUBSCRIPTION_EXPIRES = "SUBSCRIPTION_EXPIRES",
    RELATIVE_MARRIAGE_APPROACHING = "RELATIVE_MARRIAGE_APPROACHING",
    RELATIVE_DOB = "RELATIVE_DOB",
    P4P_ORDER_ACTION = "P4P_ORDER_ACTION",
    P4P_REQUEST_ACTION = "P4P_REQUEST_ACTION",
    QUIZ_MSG = "QUIZ_MSG",
}

export enum AddressFields {
    ID = "ID",
    FAMILY_ID = "FAMILY_ID",
    LINE1 = "LINE1",
    LINE2 = "LINE2",
    LINE3 = "LINE3",
    LINE4 = "LINE4",
    LAT = "LAT",
    LNG = "LNG",
    TIME_OFFSET = "TIME_OFFSET",
    TOWN = "TOWN",
    POSTCODE = "POSTCODE",
    COUNTRY = "COUNTRY",
    BUSINESS_ONLY = "BUSINESS_ONLY",
    VRFS = "VRFS",
    PARKING = "PARKING",
}

export enum MediaAlbumFields {
    ID = "ID",
    NAME = "NAME",
    DESCR = "DESCR",
    AVATAR_ID = "AVATAR_ID",
    MEDIAS = "MEDIAS",
    OWNER_ID = "OWNER_ID",
    OWNNER_FAMILY_ID = "OWNNER_FAMILY_ID",
    ACCESS = "ACCESS",
    UPDATED_DATE = "UPDATED_DATE",
}

export enum OrgAdminPublicProfileFields {
    NAME = "NAME",
    ADDRESS = "ADDRESS",
    AVATAR = "AVATAR",
    EMAIL = "EMAIL",
    VRFS = "VRFS",
    FAMILY_DESCR = "FAMILY_DESCR",
    PHONE = "PHONE",
}

export enum OrgFields {
    ID = "ID",
    NAME = "NAME",
    DESCR = "DESCR",
    AVATAR_ID = "AVATAR_ID",
    ACTIVE = "ACTIVE",
    INDIVIDUAL = "INDIVIDUAL",
    EMAIL = "EMAIL",
    WEBSITE = "WEBSITE",
    REG_DETAILS = "REG_DETAILS",
    INSURANCE = "INSURANCE",
    NON_FOR_PROFIT = "NON_FOR_PROFIT",
    PHONE = "PHONE",
    ADMIN_ID = "ADMIN_ID",
    ADMIN = "ADMIN",
    ADDR = "ADDR",
    LANGS = "LANGS",
    PORTFOLIO = "PORTFOLIO",
    SETTINGS = "SETTINGS",
    WORK_HOURS = "WORK_HOURS",
    OFF_TIME = "OFF_TIME",
    VRFS = "VRFS",
    CAL = "CAL",
}

export enum PayTxnFields {
    ID = "ID",
    EPDQ_ID = "EPDQ_ID",
    DATE = "DATE",
    PAYER_ID = "PAYER_ID",
    REF = "REF",
    STATUS = "STATUS",
    ERROR = "ERROR",
    CARD = "CARD",
    AMOUNT = "AMOUNT",
}

export enum PersonFields {
    ID = "ID",
    FAMILY_ID = "FAMILY_ID",
    ADDRESS = "ADDRESS",
    FNAME = "FNAME",
    SNAME = "SNAME",
    MNAME = "MNAME",
    MADENNAME = "MADENNAME",
    EMAIL = "EMAIL",
    GENDER = "GENDER",
    DOB = "DOB",
    PHONE = "PHONE",
    AVATAR = "AVATAR",
    CREATED = "CREATED",
    VRFS = "VRFS",
    SETTINGS = "SETTINGS",
    LANGS = "LANGS",
    OKTA_STATUS = "OKTA_STATUS",
    OKTA_STATUS_UPDATED = "OKTA_STATUS_UPDATED",
    PAY_METHODS = "PAY_METHODS",
    CAL = "CAL",
}

export enum SubscriptionFields {
    ID = "ID",
    FAMILY_ID = "FAMILY_ID",
    FROM = "FROM",
    TO = "TO",
    SUSPENDED = "SUSPENDED",
    PRODUCT = "PRODUCT",
    PAYMENTS = "PAYMENTS",
    NOTE = "NOTE",
}

export enum VerificationFields {
    ID = "ID",
    DATE = "DATE",
    TYPE = "TYPE",
    SUBJ_ID = "SUBJ_ID",
    HOLDER_TYPE = "HOLDER_TYPE",
    HOLDER_ID = "HOLDER_ID",
    EXPIRES = "EXPIRES",
    NOTES = "NOTES",
}

export enum EventType {
    BIRTHDAY = "BIRTHDAY",
    USER = "USER",
    MARRIAGE = "MARRIAGE",
    SUBSCRIPTION = "SUBSCRIPTION",
    ORG_OFFTIME = "ORG_OFFTIME",
    ORG_WORKHOURS = "ORG_WORKHOURS",
    P4P_ORDER = "P4P_ORDER",
    P4P_REQUEST = "P4P_REQUEST",
    COUNTRY_HOLIDAY = "COUNTRY_HOLIDAY",
    SCHOOL_TERMS = "SCHOOL_TERMS",
}

export enum EventNotificationType {
    NONE = "NONE",
    MINS = "MINS",
    HOURS = "HOURS",
    DAYS = "DAYS",
    WEEKS = "WEEKS",
}

export enum EventPartyStatus {
    OWNER = "OWNER",
    INVITED = "INVITED",
    ACCEPTED = "ACCEPTED",
    DECLINED = "DECLINED",
    TENTATIVE = "TENTATIVE",
}
