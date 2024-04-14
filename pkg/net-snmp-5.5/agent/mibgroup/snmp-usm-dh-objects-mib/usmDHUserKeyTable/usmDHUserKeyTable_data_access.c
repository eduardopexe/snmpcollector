/*
 * Note: this file originally auto-generated by mib2c using
 *       version : 1.17 $ of : mfd-data-access.m2c,v $ 
 *
 * $Id: usmDHUserKeyTable_data_access.c 14169 2006-01-25 16:28:12Z dts12 $
 */
/*
 * standard Net-SNMP includes 
 */
#include <net-snmp/net-snmp-config.h>
#include <net-snmp/net-snmp-includes.h>
#include <net-snmp/agent/net-snmp-agent-includes.h>

/*
 * include our parent header 
 */
#include "usmDHUserKeyTable.h"


#include "usmDHUserKeyTable_data_access.h"

/** @ingroup interface 
 * @addtogroup data_access data_access: Routines to access data
 *
 * These routines are used to locate the data used to satisfy
 * requests.
 * 
 * @{
 */
/**********************************************************************
 **********************************************************************
 ***
 *** Table usmDHUserKeyTable
 ***
 **********************************************************************
 **********************************************************************/
/*
 * SNMP-USM-DH-OBJECTS-MIB::usmDHUserKeyTable is subid 2 of usmDHPublicObjects.
 * Its status is Current.
 * OID: .1.3.6.1.3.101.1.1.2, length: 9
 */

/**
 * initialization for usmDHUserKeyTable data access
 *
 * This function is called during startup to allow you to
 * allocate any resources you need for the data table.
 *
 * @param usmDHUserKeyTable_reg
 *        Pointer to usmDHUserKeyTable_registration
 *
 * @retval MFD_SUCCESS : success.
 * @retval MFD_ERROR   : unrecoverable error.
 */
int
usmDHUserKeyTable_init_data(usmDHUserKeyTable_registration *
                            usmDHUserKeyTable_reg)
{
    DEBUGMSGTL(("verbose:usmDHUserKeyTable:usmDHUserKeyTable_init_data",
                "called\n"));

    /*
     * TODO:303:o: Initialize usmDHUserKeyTable data.
     */

    return MFD_SUCCESS;
}                               /* usmDHUserKeyTable_init_data */

/**
 * container overview
 *
 */

/**
 * container initialization
 *
 * @param container_ptr_ptr A pointer to a container pointer. If you
 *        create a custom container, use this parameter to return it
 *        to the MFD helper. If set to NULL, the MFD helper will
 *        allocate a container for you.
 * @param  cache A pointer to a cache structure. You can set the timeout
 *         and other cache flags using this pointer.
 *
 *  This function is called at startup to allow you to customize certain
 *  aspects of the access method. For the most part, it is for advanced
 *  users. The default code should suffice for most cases. If no custom
 *  container is allocated, the MFD code will create one for your.
 *
 *  This is also the place to set up cache behavior. The default, to
 *  simply set the cache timeout, will work well with the default
 *  container. If you are using a custom container, you may want to
 *  look at the cache helper documentation to see if there are any
 *  flags you want to set.
 *
 * @remark
 *  This would also be a good place to do any initialization needed
 *  for you data source. For example, opening a connection to another
 *  process that will supply the data, opening a database, etc.
 */
void
usmDHUserKeyTable_container_init(netsnmp_container ** container_ptr_ptr,
                                 netsnmp_cache * cache)
{
    DEBUGMSGTL(("verbose:usmDHUserKeyTable:usmDHUserKeyTable_container_init", "called\n"));

    if (NULL == container_ptr_ptr) {
        snmp_log(LOG_ERR,
                 "bad container param to usmDHUserKeyTable_container_init\n");
        return;
    }

    /*
     * For advanced users, you can use a custom container. If you
     * do not create one, one will be created for you.
     */
    *container_ptr_ptr = NULL;

    if (NULL == cache) {
        snmp_log(LOG_ERR,
                 "bad cache param to usmDHUserKeyTable_container_init\n");
        return;
    }

    /*
     * TODO:345:A: Set up usmDHUserKeyTable cache properties.
     *
     * Also for advanced users, you can set parameters for the
     * cache. Do not change the magic pointer, as it is used
     * by the MFD helper. To completely disable caching, set
     * cache->enabled to 0.
     *
     * other tables access our data pool (usm user list), so not caching
     * is the safest thing to do. The other option would be to add a
     * callback when the list is changed, or a last changed object to
     * verify the list hasn't changed. Until then, reload the cache for
     * every request.
       */
    cache->timeout = -1;   /* seconds */
}                               /* usmDHUserKeyTable_container_init */

/**
 * container shutdown
 *
 * @param container_ptr A pointer to the container.
 *
 *  This function is called at shutdown to allow you to customize certain
 *  aspects of the access method. For the most part, it is for advanced
 *  users. The default code should suffice for most cases.
 *
 *  This function is called before usmDHUserKeyTable_container_free().
 *
 * @remark
 *  This would also be a good place to do any cleanup needed
 *  for you data source. For example, closing a connection to another
 *  process that supplied the data, closing a database, etc.
 */
void
usmDHUserKeyTable_container_shutdown(netsnmp_container * container_ptr)
{
    DEBUGMSGTL(("verbose:usmDHUserKeyTable:usmDHUserKeyTable_container_shutdown", "called\n"));

    if (NULL == container_ptr) {
        snmp_log(LOG_ERR,
                 "bad params to usmDHUserKeyTable_container_shutdown\n");
        return;
    }

}                               /* usmDHUserKeyTable_container_shutdown */

/**
 * load initial data
 *
 * TODO:350:M: Implement usmDHUserKeyTable data load
 * This function will also be called by the cache helper to load
 * the container again (after the container free function has been
 * called to free the previous contents).
 *
 * @param container container to which items should be inserted
 *
 * @retval MFD_SUCCESS              : success.
 * @retval MFD_RESOURCE_UNAVAILABLE : Can't access data source
 * @retval MFD_ERROR                : other error.
 *
 *  This function is called to load the index(es) (and data, optionally)
 *  for the every row in the data set.
 *
 * @remark
 *  While loading the data, the only important thing is the indexes.
 *  If access to your data is cheap/fast (e.g. you have a pointer to a
 *  structure in memory), it would make sense to update the data here.
 *  If, however, the accessing the data invovles more work (e.g. parsing
 *  some other existing data, or peforming calculations to derive the data),
 *  then you can limit yourself to setting the indexes and saving any
 *  information you will need later. Then use the saved information in
 *  usmDHUserKeyTable_row_prep() for populating data.
 *
 * @note
 *  If you need consistency between rows (like you want statistics
 *  for each row to be from the same time frame), you should set all
 *  data here.
 *
 */
int
usmDHUserKeyTable_container_load(netsnmp_container * container)
{
    usmDHUserKeyTable_rowreq_ctx *rowreq_ctx;
    struct usmUser *usmuser;
    size_t          count = 0;

    DEBUGMSGTL(("verbose:usmDHUserKeyTable:usmDHUserKeyTable_container_load", "called\n"));

    /*
     * TODO:351:M: |-> Load/update data in the usmDHUserKeyTable container.
     * loop over your usmDHUserKeyTable data, allocate a rowreq context,
     * set the index(es) [and data, optionally] and insert into
     * the container.
     */
          /*
     * Retrieve the first user from the USM DB
           */
    usmuser = usm_get_userList();
    if (NULL == usmuser) {
        return MFD_SUCCESS;
    }
  
    for (; usmuser; usmuser = usmuser->next) {

        /*
         * TODO:352:M: |   |-> set indexes in new usmDHUserKeyTable rowreq context.
         * data context will be set from the first param (unless NULL,
         *      in which case a new data context will be allocated)
         * the second param will be passed, with the row context, to
         *      usmDHUserKeyTablerowreq_ctx_init.
         */
        rowreq_ctx = usmDHUserKeyTable_allocate_rowreq_ctx(usmuser, NULL);
        if (NULL == rowreq_ctx) {
            snmp_log(LOG_ERR, "memory allocation failed\n");
            return MFD_RESOURCE_UNAVAILABLE;
        }
        if (MFD_SUCCESS !=
            usmDHUserKeyTable_indexes_set(rowreq_ctx,
                                          usmuser->engineID,
                                          usmuser->engineIDLen,
                                          usmuser->name,
                                          strlen(usmuser->name))) {
            snmp_log(LOG_ERR,
                     "error setting index while loading "
                     "usmDHUserKeyTable data.\n");
            usmDHUserKeyTable_release_rowreq_ctx(rowreq_ctx);
            continue;
        }

        /*
         * TODO:352:r: |   |-> populate usmDHUserKeyTable data context.
         * Populate data context here. (optionally, delay until row prep)
         */
        /*
         * non-TRANSIENT data: no need to copy. set pointer to data 
         */

        /*
         * insert into table container
         */
        CONTAINER_INSERT(container, rowreq_ctx);
        ++count;
    }

    DEBUGMSGT(("verbose:usmDHUserKeyTable:usmDHUserKeyTable_container_load", "inserted %d records\n", count));

    return MFD_SUCCESS;
}                               /* usmDHUserKeyTable_container_load */

/**
 * container clean up
 *
 * @param container container with all current items
 *
 *  This optional callback is called prior to all
 *  item's being removed from the container. If you
 *  need to do any processing before that, do it here.
 *
 * @note
 *  The MFD helper will take care of releasing all the row contexts.
 *  If you did not pass a data context pointer when allocating
 *  the rowreq context, the one that was allocated will be deleted.
 *  If you did pass one in, it will not be deleted and that memory
 *  is your responsibility.
 *
 */
void
usmDHUserKeyTable_container_free(netsnmp_container * container)
{
    DEBUGMSGTL(("verbose:usmDHUserKeyTable:usmDHUserKeyTable_container_free", "called\n"));

    /*
     * TODO:380:M: Free usmDHUserKeyTable container data.
     */
}                               /* usmDHUserKeyTable_container_free */

/**
 * prepare row for processing.
 *
 *  When the agent has located the row for a request, this function is
 *  called to prepare the row for processing. If you fully populated
 *  the data context during the index setup phase, you may not need to
 *  do anything.
 *
 * @param rowreq_ctx pointer to a context.
 *
 * @retval MFD_SUCCESS     : success.
 * @retval MFD_ERROR       : other error.
 */
int
usmDHUserKeyTable_row_prep(usmDHUserKeyTable_rowreq_ctx * rowreq_ctx)
{
    DEBUGMSGTL(("verbose:usmDHUserKeyTable:usmDHUserKeyTable_row_prep",
                "called\n"));

    netsnmp_assert(NULL != rowreq_ctx);

    /*
     * TODO:390:o: Prepare row for request.
     * If populating row data was delayed, this is the place to
     * fill in the row for this request.
     */

    return MFD_SUCCESS;
}                               /* usmDHUserKeyTable_row_prep */

/** @} */
