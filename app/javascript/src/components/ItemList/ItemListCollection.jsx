// Sidebar tags for collection list page
import { h } from 'preact';
import { PropTypes } from 'preact-compat';

export const ItemListCollection = ({
  availableTags,
  selectedTags,
  onClick,
}) => {
  const tagsHTML = availableTags.map(tag => (
    <a
      className={`tag ${selectedTags.indexOf(tag) > -1 ? 'selected' : ''}`}
      href={`/t/${tag}`}
      data-no-instant
      onClick={e => onClick(e, tag)}
    >
      {`${tag}`}
    </a>
  ));
  return <div className="tags">{tagsHTML}</div>;
};

ItemListCollection.propTypes = {
  availableTags: PropTypes.arrayOf(PropTypes.string).isRequired,
  selectedTags: PropTypes.arrayOf(PropTypes.string).isRequired,
  onClick: PropTypes.func.isRequired,
};
