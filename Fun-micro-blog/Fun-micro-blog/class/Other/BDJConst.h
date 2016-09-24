
#import <UIKit/UIKit.h>
typedef enum {
    BDJTopicTypeAll = 1,
    BDJTopicTypePicture = 10,
    BDJTopicTypeWord = 29,
    BDJTopicTypeVoice = 31,
    BDJTopicTypeVideo = 41
} BDJTopicType;

/**
 *  间距
 */
UIKIT_EXTERN CGFloat const BDJTopicMargin;

/**
 *  cell的评论按钮的高度
 */
UIKIT_EXTERN CGFloat const BDJTopicBottomBarH;
/**
 *  头像的最大Y值
 */
UIKIT_EXTERN CGFloat const BDJTopicHeadH;

/**
 *  图片超过这个值需要显示按钮
 */
UIKIT_EXTERN CGFloat const BDJTopicPictureMaxH;
/**
 *  显示图片的高度
 */
UIKIT_EXTERN CGFloat const BDJTopicShowPictureH;

/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const BDJTopicCellTopCmtTitleH;

///** BDJUser模型-性别属性值 */
UIKIT_EXTERN NSString * const BDJUserSexMale;
UIKIT_EXTERN NSString * const BDJUserSexFemale;
