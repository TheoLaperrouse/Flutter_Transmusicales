// To parse this JSON data, do
//
//     final transData = transDataFromJson(jsonString);

import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';


Future<List> getDataFromJson() async{
  String jsonResult;
  Future<String> getFileData() async {
    return await rootBundle.loadString('assets/transData.json');
  }
  await getFileData().then((String json) { jsonResult = json; });
  return transDataFromJson(jsonResult);
}

List<TransData> transDataFromJson(String str) => List<TransData>.from(json.decode(str).map((x) => TransData.fromJson(x)));

String transDataToJson(List<TransData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TransData {
  TransData({
    this.datasetid,
    this.recordid,
    this.fields,
    this.geometry,
    this.recordTimestamp,
  });

  Datasetid datasetid;
  String recordid;
  Fields fields;
  Geometry geometry;
  DateTime recordTimestamp;

  factory TransData.fromJson(Map<String, dynamic> json) => TransData(
    datasetid: datasetidValues.map[json["datasetid"]],
    recordid: json["recordid"],
    fields: Fields.fromJson(json["fields"]),
    geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    recordTimestamp: DateTime.parse(json["record_timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "datasetid": datasetidValues.reverse[datasetid],
    "recordid": recordid,
    "fields": fields.toJson(),
    "geometry": geometry == null ? null : geometry.toJson(),
    "record_timestamp": recordTimestamp.toIso8601String(),
  };
}

enum Datasetid { DATAMIX_EUROPE_TRANSMUSICALES }

final datasetidValues = EnumValues({
  "datamix-europe-transmusicales": Datasetid.DATAMIX_EUROPE_TRANSMUSICALES
});

class Fields {
  Fields({
    this.spotify,
    this.the1EreDateTimestamp,
    this.couOfficialLangCode,
    this.couOnuCode,
    this.artistes,
    this.couIso2Code,
    this.geoPoint2D,
    this.couIso3Code,
    this.the1EreSalle,
    this.couIsReceivingQuest,
    this.edition,
    this.couTextSp,
    this.the1EreDate,
    this.couIsIlomember,
    this.annee,
    this.deezer,
    this.couTextEn,
    this.originePays1,
    this.origineVille1,
    this.the2EmeDateTimestamp,
    this.the3EmeProjet,
    this.the2EmeDate,
    this.the1ErProjetAtm,
    this.the4EmeDate,
    this.the2EmeProjet,
    this.the3EmeDate,
    this.the3EmeDateTimestamp,
    this.the4EmeDateTimestamp,
    this.the2EmeSalle,
    this.the3EmeSalle,
    this.the4EmeSalle,
    this.column48,
    this.the6EmeDate,
    this.the6EmeDateTimestamp,
    this.column47,
    this.the6EmeSalle,
    this.column46,
    this.the5EmeDate,
    this.the5EmeDateTimestamp,
    this.the5EmeSalle,
    this.origineVille2,
    this.originePays2,
    this.nomSpectacleOuSoiree,
    this.the4EmeProjet,
    this.column45,
    this.the6EmeProjet,
    this.originePays4,
    this.originePays3,
    this.the5EmeProjet,
    this.the4EmeVille,
    this.the3EmeVille,
    this.origineVille4,
    this.origineVille3,
    this.the2EmeVille,
    this.the1EreVille,
  });

  String spotify;
  int the1EreDateTimestamp;
  CouOfficialLangCode couOfficialLangCode;
  String couOnuCode;
  String artistes;
  String couIso2Code;
  List<double> geoPoint2D;
  String couIso3Code;
  String the1EreSalle;
  CouIs couIsReceivingQuest;
  Edition edition;
  String couTextSp;
  String the1EreDate;
  CouIs couIsIlomember;
  String annee;
  String deezer;
  String couTextEn;
  String originePays1;
  String origineVille1;
  int the2EmeDateTimestamp;
  The1ErProjetAtm the3EmeProjet;
  String the2EmeDate;
  The1ErProjetAtm the1ErProjetAtm;
  String the4EmeDate;
  The1ErProjetAtm the2EmeProjet;
  String the3EmeDate;
  int the3EmeDateTimestamp;
  int the4EmeDateTimestamp;
  String the2EmeSalle;
  String the3EmeSalle;
  String the4EmeSalle;
  String column48;
  String the6EmeDate;
  int the6EmeDateTimestamp;
  String column47;
  String the6EmeSalle;
  String column46;
  String the5EmeDate;
  int the5EmeDateTimestamp;
  String the5EmeSalle;
  String origineVille2;
  String originePays2;
  String nomSpectacleOuSoiree;
  The1ErProjetAtm the4EmeProjet;
  The1ErProjetAtm column45;
  The1ErProjetAtm the6EmeProjet;
  String originePays4;
  String originePays3;
  The1ErProjetAtm the5EmeProjet;
  String the4EmeVille;
  String the3EmeVille;
  String origineVille4;
  String origineVille3;
  String the2EmeVille;
  String the1EreVille;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    spotify: json["spotify"] == null ? null : json["spotify"],
    the1EreDateTimestamp: json["1ere_date_timestamp"] == null ? null : json["1ere_date_timestamp"],
    couOfficialLangCode: json["cou_official_lang_code"] == null ? null : couOfficialLangCodeValues.map[json["cou_official_lang_code"]],
    couOnuCode: json["cou_onu_code"] == null ? null : json["cou_onu_code"],
    artistes: json["artistes"],
    couIso2Code: json["cou_iso2_code"] == null ? null : json["cou_iso2_code"],
    geoPoint2D: json["geo_point_2d"] == null ? null : List<double>.from(json["geo_point_2d"].map((x) => x.toDouble())),
    couIso3Code: json["cou_iso3_code"] == null ? null : json["cou_iso3_code"],
    the1EreSalle: json["1ere_salle"] == null ? null : json["1ere_salle"],
    couIsReceivingQuest: json["cou_is_receiving_quest"] == null ? null : couIsValues.map[json["cou_is_receiving_quest"]],
    edition: json["edition"] == null ? null : editionValues.map[json["edition"]],
    couTextSp: json["cou_text_sp"] == null ? null : json["cou_text_sp"],
    the1EreDate: json["1ere_date"] == null ? null : json["1ere_date"],
    couIsIlomember: json["cou_is_ilomember"] == null ? null : couIsValues.map[json["cou_is_ilomember"]],
    annee: json["annee"] == null ? null : json["annee"],
    deezer: json["deezer"] == null ? null : json["deezer"],
    couTextEn: json["cou_text_en"] == null ? null : json["cou_text_en"],
    originePays1: json["origine_pays1"] == null ? null : json["origine_pays1"],
    origineVille1: json["origine_ville1"] == null ? null : json["origine_ville1"],
    the2EmeDateTimestamp: json["2eme_date_timestamp"] == null ? null : json["2eme_date_timestamp"],
    the3EmeProjet: json["3eme_projet"] == null ? null : the1ErProjetAtmValues.map[json["3eme_projet"]],
    the2EmeDate: json["2eme_date"] == null ? null : json["2eme_date"],
    the1ErProjetAtm: json["1er_projet_atm"] == null ? null : the1ErProjetAtmValues.map[json["1er_projet_atm"]],
    the4EmeDate: json["4eme_date"] == null ? null : json["4eme_date"],
    the2EmeProjet: json["2eme_projet"] == null ? null : the1ErProjetAtmValues.map[json["2eme_projet"]],
    the3EmeDate: json["3eme_date"] == null ? null : json["3eme_date"],
    the3EmeDateTimestamp: json["3eme_date_timestamp"] == null ? null : json["3eme_date_timestamp"],
    the4EmeDateTimestamp: json["4eme_date_timestamp"] == null ? null : json["4eme_date_timestamp"],
    the2EmeSalle: json["2eme_salle"] == null ? null : json["2eme_salle"],
    the3EmeSalle: json["3eme_salle"] == null ? null : json["3eme_salle"],
    the4EmeSalle: json["4eme_salle"] == null ? null : json["4eme_salle"],
    column48: json["column_48"] == null ? null : json["column_48"],
    the6EmeDate: json["6eme_date"] == null ? null : json["6eme_date"],
    the6EmeDateTimestamp: json["6eme_date_timestamp"] == null ? null : json["6eme_date_timestamp"],
    column47: json["column_47"] == null ? null : json["column_47"],
    the6EmeSalle: json["6eme_salle"] == null ? null : json["6eme_salle"],
    column46: json["column_46"] == null ? null : json["column_46"],
    the5EmeDate: json["5eme_date"] == null ? null : json["5eme_date"],
    the5EmeDateTimestamp: json["5eme_date_timestamp"] == null ? null : json["5eme_date_timestamp"],
    the5EmeSalle: json["5eme_salle"] == null ? null : json["5eme_salle"],
    origineVille2: json["origine_ville2"] == null ? null : json["origine_ville2"],
    originePays2: json["origine_pays2"] == null ? null : json["origine_pays2"],
    nomSpectacleOuSoiree: json["nom_spectacle_ou_soiree"] == null ? null : json["nom_spectacle_ou_soiree"],
    the4EmeProjet: json["4eme_projet"] == null ? null : the1ErProjetAtmValues.map[json["4eme_projet"]],
    column45: json["column_45"] == null ? null : the1ErProjetAtmValues.map[json["column_45"]],
    the6EmeProjet: json["6eme_projet"] == null ? null : the1ErProjetAtmValues.map[json["6eme_projet"]],
    originePays4: json["origine_pays4"] == null ? null : json["origine_pays4"],
    originePays3: json["origine_pays3"] == null ? null : json["origine_pays3"],
    the5EmeProjet: json["5eme_projet"] == null ? null : the1ErProjetAtmValues.map[json["5eme_projet"]],
    the4EmeVille: json["4eme_ville"] == null ? null : json["4eme_ville"],
    the3EmeVille: json["3eme_ville"] == null ? null : json["3eme_ville"],
    origineVille4: json["origine_ville4"] == null ? null : json["origine_ville4"],
    origineVille3: json["origine_ville3"] == null ? null : json["origine_ville3"],
    the2EmeVille: json["2eme_ville"] == null ? null : json["2eme_ville"],
    the1EreVille: json["1ere_ville"] == null ? null : json["1ere_ville"],
  );

  Map<String, dynamic> toJson() => {
    "spotify": spotify == null ? null : spotify,
    "1ere_date_timestamp": the1EreDateTimestamp == null ? null : the1EreDateTimestamp,
    "cou_official_lang_code": couOfficialLangCode == null ? null : couOfficialLangCodeValues.reverse[couOfficialLangCode],
    "cou_onu_code": couOnuCode == null ? null : couOnuCode,
    "artistes": artistes,
    "cou_iso2_code": couIso2Code == null ? null : couIso2Code,
    "geo_point_2d": geoPoint2D == null ? null : List<dynamic>.from(geoPoint2D.map((x) => x)),
    "cou_iso3_code": couIso3Code == null ? null : couIso3Code,
    "1ere_salle": the1EreSalle == null ? null : the1EreSalle,
    "cou_is_receiving_quest": couIsReceivingQuest == null ? null : couIsValues.reverse[couIsReceivingQuest],
    "edition": edition == null ? null : editionValues.reverse[edition],
    "cou_text_sp": couTextSp == null ? null : couTextSp,
    "1ere_date": the1EreDate == null ? null : the1EreDate,
    "cou_is_ilomember": couIsIlomember == null ? null : couIsValues.reverse[couIsIlomember],
    "annee": annee == null ? null : annee,
    "deezer": deezer == null ? null : deezer,
    "cou_text_en": couTextEn == null ? null : couTextEn,
    "origine_pays1": originePays1 == null ? null : originePays1,
    "origine_ville1": origineVille1 == null ? null : origineVille1,
    "2eme_date_timestamp": the2EmeDateTimestamp == null ? null : the2EmeDateTimestamp,
    "3eme_projet": the3EmeProjet == null ? null : the1ErProjetAtmValues.reverse[the3EmeProjet],
    "2eme_date": the2EmeDate == null ? null : the2EmeDate,
    "1er_projet_atm": the1ErProjetAtm == null ? null : the1ErProjetAtmValues.reverse[the1ErProjetAtm],
    "4eme_date": the4EmeDate == null ? null : the4EmeDate,
    "2eme_projet": the2EmeProjet == null ? null : the1ErProjetAtmValues.reverse[the2EmeProjet],
    "3eme_date": the3EmeDate == null ? null : the3EmeDate,
    "3eme_date_timestamp": the3EmeDateTimestamp == null ? null : the3EmeDateTimestamp,
    "4eme_date_timestamp": the4EmeDateTimestamp == null ? null : the4EmeDateTimestamp,
    "2eme_salle": the2EmeSalle == null ? null : the2EmeSalle,
    "3eme_salle": the3EmeSalle == null ? null : the3EmeSalle,
    "4eme_salle": the4EmeSalle == null ? null : the4EmeSalle,
    "column_48": column48 == null ? null : column48,
    "6eme_date": the6EmeDate == null ? null : the6EmeDate,
    "6eme_date_timestamp": the6EmeDateTimestamp == null ? null : the6EmeDateTimestamp,
    "column_47": column47 == null ? null : column47,
    "6eme_salle": the6EmeSalle == null ? null : the6EmeSalle,
    "column_46": column46 == null ? null : column46,
    "5eme_date": the5EmeDate == null ? null : the5EmeDate,
    "5eme_date_timestamp": the5EmeDateTimestamp == null ? null : the5EmeDateTimestamp,
    "5eme_salle": the5EmeSalle == null ? null : the5EmeSalle,
    "origine_ville2": origineVille2 == null ? null : origineVille2,
    "origine_pays2": originePays2 == null ? null : originePays2,
    "nom_spectacle_ou_soiree": nomSpectacleOuSoiree == null ? null : nomSpectacleOuSoiree,
    "4eme_projet": the4EmeProjet == null ? null : the1ErProjetAtmValues.reverse[the4EmeProjet],
    "column_45": column45 == null ? null : the1ErProjetAtmValues.reverse[column45],
    "6eme_projet": the6EmeProjet == null ? null : the1ErProjetAtmValues.reverse[the6EmeProjet],
    "origine_pays4": originePays4 == null ? null : originePays4,
    "origine_pays3": originePays3 == null ? null : originePays3,
    "5eme_projet": the5EmeProjet == null ? null : the1ErProjetAtmValues.reverse[the5EmeProjet],
    "4eme_ville": the4EmeVille == null ? null : the4EmeVille,
    "3eme_ville": the3EmeVille == null ? null : the3EmeVille,
    "origine_ville4": origineVille4 == null ? null : origineVille4,
    "origine_ville3": origineVille3 == null ? null : origineVille3,
    "2eme_ville": the2EmeVille == null ? null : the2EmeVille,
    "1ere_ville": the1EreVille == null ? null : the1EreVille,
  };
}

enum The1ErProjetAtm { KALIDOSCOPE, TOURNE_DES_TRANS_HIP_HOP_EN_TRANS, CRATION, TOURNE_DES_TRANS, THE_1_ER_PROJET_ATM_TOURNE_DES_TRANS, CONFRENCE_CONCERT_DU_JEU_DE_L_OUE, QUARTIERS_EN_TRANS, DANSE_HIP_HOP, FOCUS, LES_TRANS_DANS_LES_PRISONS, THE_1_ER_PROJET_ATM_CONFRENCE_CONCERT_DU_JEU_DE_L_OUE, FOCUS_EUROPEN, FOCUS_SUISSE, ONE_MORE, FOCUS_ASIE, APRO_TRANS, BARS_EN_TRANS, FOCUS_PAYS_BAS, CONCERT_810_ANS, PURPLE_CONFRENCE_CONCERT_DU_JEU_DE_L_OUE, RENCONTRES_ET_DBATS, FLUFFY_CONFRENCE_CONCERT_DU_JEU_DE_L_OUE, CONCERT_DES_FAMILLES }

final the1ErProjetAtmValues = EnumValues({
  "Apéro'Trans": The1ErProjetAtm.APRO_TRANS,
  "Bars en Trans": The1ErProjetAtm.BARS_EN_TRANS,
  "Concert 8-10 ans": The1ErProjetAtm.CONCERT_810_ANS,
  "Concert des Familles": The1ErProjetAtm.CONCERT_DES_FAMILLES,
  "Conférence-Concert du Jeu de L'Ouïe": The1ErProjetAtm.CONFRENCE_CONCERT_DU_JEU_DE_L_OUE,
  "Création": The1ErProjetAtm.CRATION,
  "Danse Hip-Hop": The1ErProjetAtm.DANSE_HIP_HOP,
  "Conférence-concert du Jeu de l'Ouïe": The1ErProjetAtm.FLUFFY_CONFRENCE_CONCERT_DU_JEU_DE_L_OUE,
  "Focus": The1ErProjetAtm.FOCUS,
  "Focus Asie": The1ErProjetAtm.FOCUS_ASIE,
  "Focus Européen": The1ErProjetAtm.FOCUS_EUROPEN,
  "Focus Pays-Bas": The1ErProjetAtm.FOCUS_PAYS_BAS,
  "Focus Suisse": The1ErProjetAtm.FOCUS_SUISSE,
  "Kaléidoscope": The1ErProjetAtm.KALIDOSCOPE,
  "Les Trans dans les Prisons": The1ErProjetAtm.LES_TRANS_DANS_LES_PRISONS,
  "One More !": The1ErProjetAtm.ONE_MORE,
  "Conférence-concert du Jeu de L'Ouïe": The1ErProjetAtm.PURPLE_CONFRENCE_CONCERT_DU_JEU_DE_L_OUE,
  "Quartiers en Trans": The1ErProjetAtm.QUARTIERS_EN_TRANS,
  "Rencontres et Débats": The1ErProjetAtm.RENCONTRES_ET_DBATS,
  "Conférence-Concert du Jeu de l'Ouïe": The1ErProjetAtm.THE_1_ER_PROJET_ATM_CONFRENCE_CONCERT_DU_JEU_DE_L_OUE,
  "Tournée des trans": The1ErProjetAtm.THE_1_ER_PROJET_ATM_TOURNE_DES_TRANS,
  "Tournée des Trans": The1ErProjetAtm.TOURNE_DES_TRANS,
  "Tournée des Trans, Hip-Hop en Trans": The1ErProjetAtm.TOURNE_DES_TRANS_HIP_HOP_EN_TRANS
});

enum CouIs { Y, N }

final couIsValues = EnumValues({
  "N": CouIs.N,
  "Y": CouIs.Y
});

enum CouOfficialLangCode { EN, FR, SP }

final couOfficialLangCodeValues = EnumValues({
  "EN": CouOfficialLangCode.EN,
  "FR": CouOfficialLangCode.FR,
  "SP": CouOfficialLangCode.SP
});

enum Edition { THE_26_MES_RENCONTRES_TRANS_MUSICALES, THE_25_MES_RENCONTRES_TRANS_MUSICALES, THE_22_MES_RENCONTRES_TRANS_MUSICALES, THE_24_MES_RENCONTRES_TRANS_MUSICALES, THE_23_MES_RENCONTRES_TRANS_MUSICALES, THE_21_MES_RENCONTRES_TRANS_MUSICALES, THE_34_MES_RENCONTRES_TRANS_MUSICALES, THE_31_MES_RENCONTRES_TRANS_MUSICALES, THE_33_MES_RENCONTRES_TRANS_MUSICALES, THE_32_MES_RENCONTRES_TRANS_MUSICALES, THE_29_MES_RENCONTRES_TRANS_MUSICALES, THE_30_MES_RENCONTRES_TRANS_MUSICALES, THE_28_MES_RENCONTRES_TRANS_MUSICALES, THE_35_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_36_MES_RENCONTRES_TRANS_MUSICALES, THE_37_MES_RENCONTRES_TRANS_MUSICALES, THE_38_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_39_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_40_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_41_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_10_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_9_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_8_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_7_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_6_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_5_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_3_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_4_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_2_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_1_RES_RENCONTRES_TRANS_MUSICALES_DE_RENNES, THE_15_MES_RENCONTRES_TRANS_MUSICALES, THE_14_MES_RENCONTRES_TRANS_MUSICALES, THE_11_MES_RENCONTRES_TRANS_MUSICALES, THE_13_MES_RENCONTRES_TRANS_MUSICALES, THE_12_MES_RENCONTRES_TRANS_MUSICALES, THE_20_MES_RENCONTRES_TRANS_MUSICALES, THE_19_MES_RENCONTRES_TRANS_MUSICALES, THE_18_MES_RENCONTRES_TRANS_MUSICALES, THE_17_MES_RENCONTRES_TRANS_MUSICALES, THE_16_MES_RENCONTRES_TRANS_MUSICALES, THE_27_MES_RENCONTRES_TRANS_MUSICALES }

final editionValues = EnumValues({
  "10èmes Rencontres Trans Musicales de Rennes": Edition.THE_10_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "11èmes Rencontres Trans Musicales": Edition.THE_11_MES_RENCONTRES_TRANS_MUSICALES,
  "12èmes Rencontres Trans Musicales": Edition.THE_12_MES_RENCONTRES_TRANS_MUSICALES,
  "13èmes Rencontres Trans Musicales": Edition.THE_13_MES_RENCONTRES_TRANS_MUSICALES,
  "14èmes Rencontres Trans Musicales": Edition.THE_14_MES_RENCONTRES_TRANS_MUSICALES,
  "15èmes Rencontres Trans Musicales": Edition.THE_15_MES_RENCONTRES_TRANS_MUSICALES,
  "16èmes Rencontres Trans Musicales": Edition.THE_16_MES_RENCONTRES_TRANS_MUSICALES,
  "17èmes Rencontres Trans Musicales": Edition.THE_17_MES_RENCONTRES_TRANS_MUSICALES,
  "18èmes Rencontres Trans Musicales": Edition.THE_18_MES_RENCONTRES_TRANS_MUSICALES,
  "19èmes Rencontres Trans Musicales": Edition.THE_19_MES_RENCONTRES_TRANS_MUSICALES,
  "1ères  Rencontres Trans Musicales de Rennes": Edition.THE_1_RES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "20èmes Rencontres Trans Musicales": Edition.THE_20_MES_RENCONTRES_TRANS_MUSICALES,
  "21èmes Rencontres Trans Musicales": Edition.THE_21_MES_RENCONTRES_TRANS_MUSICALES,
  "22èmes Rencontres Trans Musicales": Edition.THE_22_MES_RENCONTRES_TRANS_MUSICALES,
  "23èmes Rencontres Trans Musicales": Edition.THE_23_MES_RENCONTRES_TRANS_MUSICALES,
  "24èmes Rencontres Trans Musicales": Edition.THE_24_MES_RENCONTRES_TRANS_MUSICALES,
  "25èmes Rencontres Trans Musicales": Edition.THE_25_MES_RENCONTRES_TRANS_MUSICALES,
  "26èmes Rencontres Trans Musicales": Edition.THE_26_MES_RENCONTRES_TRANS_MUSICALES,
  "27èmes Rencontres Trans Musicales": Edition.THE_27_MES_RENCONTRES_TRANS_MUSICALES,
  "28èmes Rencontres Trans Musicales": Edition.THE_28_MES_RENCONTRES_TRANS_MUSICALES,
  "29èmes Rencontres Trans Musicales": Edition.THE_29_MES_RENCONTRES_TRANS_MUSICALES,
  "2èmes Rencontres Trans Musicales de Rennes": Edition.THE_2_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "30èmes Rencontres Trans Musicales": Edition.THE_30_MES_RENCONTRES_TRANS_MUSICALES,
  "31èmes Rencontres Trans Musicales": Edition.THE_31_MES_RENCONTRES_TRANS_MUSICALES,
  "32èmes Rencontres Trans Musicales": Edition.THE_32_MES_RENCONTRES_TRANS_MUSICALES,
  "33èmes Rencontres Trans Musicales": Edition.THE_33_MES_RENCONTRES_TRANS_MUSICALES,
  "34èmes Rencontres Trans Musicales": Edition.THE_34_MES_RENCONTRES_TRANS_MUSICALES,
  "35èmes Rencontres Trans Musicales de Rennes": Edition.THE_35_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "36èmes Rencontres Trans Musicales": Edition.THE_36_MES_RENCONTRES_TRANS_MUSICALES,
  "37èmes Rencontres Trans Musicales": Edition.THE_37_MES_RENCONTRES_TRANS_MUSICALES,
  "38èmes Rencontres Trans Musicales de Rennes": Edition.THE_38_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "39èmes Rencontres Trans Musicales de Rennes": Edition.THE_39_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "3èmes Rencontres Trans Musicales de Rennes": Edition.THE_3_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "40èmes Rencontres Trans Musicales de Rennes": Edition.THE_40_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "41èmes Rencontres Trans Musicales de Rennes": Edition.THE_41_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "4èmes Rencontres Trans Musicales de Rennes": Edition.THE_4_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "5èmes Rencontres Trans Musicales de Rennes": Edition.THE_5_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "6èmes Rencontres Trans Musicales de Rennes": Edition.THE_6_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "7èmes Rencontres Trans Musicales de Rennes": Edition.THE_7_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "8èmes Rencontres Trans Musicales de Rennes": Edition.THE_8_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES,
  "9èmes Rencontres Trans Musicales de Rennes": Edition.THE_9_MES_RENCONTRES_TRANS_MUSICALES_DE_RENNES
});

class Geometry {
  Geometry({
    this.type,
    this.coordinates,
  });

  Type type;
  List<double> coordinates;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    type: typeValues.map[json["type"]],
    coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

enum Type { POINT }

final typeValues = EnumValues({
  "Point": Type.POINT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
